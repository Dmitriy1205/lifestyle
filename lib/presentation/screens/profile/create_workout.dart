import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/data/models/workout.dart';
import 'package:lifestyle/presentation/bloc/profile/create_workout/create_workout_cubit.dart';
import 'package:lifestyle/presentation/screens/profile/relax_builder.dart';
import 'package:lifestyle/presentation/widgets/image_picker.dart';
import 'package:lifestyle/presentation/widgets/loading_indicator.dart';
import 'package:lifestyle/presentation/widgets/small_workout_picture.dart';
import 'package:lifestyle/presentation/widgets/workout_template.dart';
import '../../../common/constants/colors.dart';
import '../../../common/constants/constants.dart';
import '../../../common/themes/theme.dart';
import 'exercise_builder.dart';

class CreateWorkout extends StatelessWidget {
  const CreateWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateWorkoutCubit, CreateWorkoutState>(
      builder: (context, state) {
        if (state.status!.isLoading) {
          return const Material(
            child: LoadingIndicator(),
          );
        }
        return EditableWorkoutTemplate(
          imagePicker: PicturePicker(
            userImage: (image) {
              context.read<CreateWorkoutCubit>().getImage(image);
            },
          ),
          initialName: state.nameController,
          initialDescription: state.descController,
          initialRecommendation: state.recomController,
          buttonName: AppText.create,
          onButtonClick: () {
            context
                .read<CreateWorkoutCubit>()
                .createExercise(
                  Workout()
                    ..name = state.nameController!.text
                    ..description = state.descController!.text
                    ..recommendation = state.recomController!.text
                    ..exercises = state.group!,
                  state.image!,
                )
                .then((value) => Navigator.pop(context));
          },
          toRelax: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RelaxBuilder(
                  add: (value) {
                    context.read<CreateWorkoutCubit>().addRelax(value);
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
                    context.read<CreateWorkoutCubit>().addExercise(exercise);
                  },
                ),
              ),
            );
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
                                    SmallWorkoutPicture(image: state.group![index].exercise!.image!),
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
                                            .read<CreateWorkoutCubit>()
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
                        state.group![index].relaxTime == null
                            ? const SizedBox()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                child: Row(
                                  children: [
                                    Text(
                                      '${AppText.relax} ${state.group![index].relaxTime} ${AppText.seconds}',
                                      style: AppTheme
                                          .themeData.textTheme.displayMedium!
                                          .copyWith(fontSize: 12),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<CreateWorkoutCubit>()
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
