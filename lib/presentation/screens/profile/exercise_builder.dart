import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifestyle/presentation/bloc/profile/exercise_builder/exercise_builder_cubit.dart';
import 'package:lifestyle/presentation/screens/profile/add_training.dart';
import 'package:lifestyle/presentation/widgets/loading_indicator.dart';
import 'package:lifestyle/presentation/widgets/small_workout_picture.dart';

import '../../../common/constants/colors.dart';
import '../../../common/constants/constants.dart';
import '../../../common/constants/icons.dart';
import '../../../common/services/service_locator.dart';
import '../../../common/themes/theme.dart';
import '../../../data/models/exercises.dart';

class ExerciseBuilder extends StatelessWidget {
  final Function(Exercises) addExercise;

  const ExerciseBuilder({Key? key, required this.addExercise})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ExerciseBuilderCubit>(),
      child: Scaffold(
        
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              AppIcons.back,
              color: AppColors.contrast,
              size: 20,
            ),
          ),
          title: Text(
            AppText.trainings,
            style: AppTheme.themeData.textTheme.displayLarge,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<ExerciseBuilderCubit, ExerciseBuilderState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                children: [
                  TextFormField(
                    controller: state.controller,
                    style: AppTheme.themeData.textTheme.displayMedium,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      hintText: AppText.search,
                    ),
                    onChanged: (String name) {
                      context.read<ExerciseBuilderCubit>().searchExercise(name);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  state.status!.isLoading
                      ? Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 3),
                          child: const LoadingIndicator(),
                        )
                      : state.status!.isError
                          ? Center(
                              child: Text(
                                state.status!.errorMessage!,
                                style: AppTheme.themeData.textTheme.titleSmall,
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: state.files!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddTrainingScreen(
                                            name: state.files![index].name!,
                                            image: state.files![index].path!,
                                            addExercise: addExercise,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Row(
                                        children: [
                                          SmallWorkoutPicture(
                                              image: state.files![index].path!),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.files![index].name!,
                                                style: AppTheme.themeData
                                                    .textTheme.bodyMedium!
                                                    .copyWith(
                                                        color:
                                                            AppColors.contrast,
                                                        fontSize: 14),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
