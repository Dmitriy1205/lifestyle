import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/data/models/group.dart';
import 'package:lifestyle/presentation/screens/profile/relax_builder.dart';
import 'package:lifestyle/presentation/widgets/small_workout_picture.dart';
import 'package:lifestyle/presentation/widgets/workout_template.dart';
import '../../../common/constants/colors.dart';
import '../../../common/constants/constants.dart';
import '../../../common/themes/theme.dart';
import '../../../data/models/workout.dart';
import '../../bloc/profile/edit_workout/edit_workout_cubit.dart';
import '../../widgets/connection_message.dart';
import '../../widgets/image_picker.dart';
import 'exercise_builder.dart';

class EditWorkout extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  final String description;
  final String recommendation;
  final List<Group> exercises;
  final String category;

  const EditWorkout({
    Key? key,
    required this.name,
    required this.description,
    required this.recommendation,
    required this.exercises,
    required this.id,
    required this.image, required this.category,
  }) : super(key: key);

  @override
  State<EditWorkout> createState() => _EditWorkoutState();
}

class _EditWorkoutState extends State<EditWorkout> {
  @override
  void initState() {
    context.read<EditWorkoutCubit>().init(widget.exercises, widget.name,
        widget.description, widget.recommendation,widget.category,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditWorkoutCubit, EditWorkoutState>(
      builder: (context, state) {
        if (state.status!.isLoading) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.mainAccent,
              ),
            ),
          );
        }
        return EditableWorkoutTemplate(
          imagePicker: PicturePicker(
            userImage: (image) {
              context.read<EditWorkoutCubit>().getImage(image);
            },
          ),
          categoryChoose: (category) {
            context.read<EditWorkoutCubit>().setCategory(category);
          },
          category: state.category,
          initialName: state.nameController,
          initialDescription: state.descController,
          initialRecommendation: state.recomController,
          buttonName: AppText.edit,
          toRelax: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RelaxBuilder(
                  add: (value) {
                    context.read<EditWorkoutCubit>().addRelax(value);
                  },
                ),
              ),
            );
          },
          toTraining: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExerciseBuilder(
                  addExercise: (exercise) {
                    context.read<EditWorkoutCubit>().addExercise(exercise);
                  },
                ),
              ),
            );
          },
          onButtonClick: () {
            state.source == Source.cache
                ? ConnectionMessage.buildErrorSnackbar(context)
                : context
                .read<EditWorkoutCubit>()
                .editExercise(
                  Workout()
                    ..name = state.nameController!.text
                    ..description = state.descController!.text
                    ..recommendation = state.recomController!.text
                    ..exercises = state.group!
                    ..id = widget.id
                    ..category = state.categoryName,
                  state.image,
                  widget.image,
                )
                .then((value) {
              Navigator.pop(context);
              Navigator.pop(context);
            });
          },
          exerciseList: state.group == null
              ? const SizedBox()
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.group!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        state.group![index].exercise == null
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    SmallWorkoutPicture(
                                        image: state
                                            .group![index].exercise!.image!),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.group![index].exercise!.name!,
                                          style: AppTheme
                                              .themeData.textTheme.bodyMedium!
                                              .copyWith(
                                                  color: AppColors.contrast,
                                                  fontSize: 12),
                                        ),
                                        Text(
                                          '${state.group![index].exercise!.duration!} ${state.group![index].exercise!.timeValue!}',
                                          style: AppTheme
                                              .themeData.textTheme.bodyMedium!
                                              .copyWith(
                                                  color: AppColors.contrast,
                                                  fontSize: 8),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<EditWorkoutCubit>()
                                            .deleteExercise(index);
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.trash,
                                        color: AppColors.red,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        state.group![index].relaxTime == 'null' ||
                                state.group![index].relaxTime == null
                            ? const SizedBox()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                child: Row(
                                  children: [
                                    Text(
                                      '${AppText.rest} ${state.group![index].relaxTime} ${AppText.seconds}',
                                      style: AppTheme
                                          .themeData.textTheme.displayMedium!
                                          .copyWith(fontSize: 12),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<EditWorkoutCubit>()
                                            .deleteRelaxTime(index);
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.trash,
                                        color: AppColors.red,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    );
                  }),
        );
      },
    );
  }
}
