import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/presentation/bloc/profile/your_workout/your_workout_cubit.dart';
import 'package:lifestyle/presentation/screens/profile/create_workout.dart';
import 'package:lifestyle/presentation/screens/profile/deatails_screen.dart';
import 'package:lifestyle/presentation/widgets/loading_indicator.dart';
import 'package:lifestyle/presentation/widgets/small_workout_picture.dart';

import '../../../common/constants/colors.dart';
import '../../../common/constants/constants.dart';
import '../../../common/constants/icons.dart';
import '../../../common/themes/theme.dart';

class YourWorkouts extends StatefulWidget {
  const YourWorkouts({Key? key}) : super(key: key);

  @override
  State<YourWorkouts> createState() => _YourWorkoutsState();
}

class _YourWorkoutsState extends State<YourWorkouts> {
  @override
  void initState() {
    context.read<YourWorkoutCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        centerTitle: true,
        title: Text(
          AppText.workouts.toUpperCase(),
          style: AppTheme.themeData.textTheme.displayLarge,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: AppColors.mainAccent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40.0),
            ),
          ),
          child: const FaIcon(
            FontAwesomeIcons.plus,
            color: AppColors.contrast,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CreateWorkout(),
              ),
            ).then((value) => context.read<YourWorkoutCubit>().init());
          },
        ),
      ),
      body: BlocBuilder<YourWorkoutCubit, YourWorkoutState>(
        builder: (context, state) {
          if (state.status!.isLoading) {
            return const LoadingIndicator();
          }
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 30),
                  child: ListView.builder(
                      itemCount: state.workout!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailsScreen(
                                  header: state.workout![index].name!,
                                  interval: state.workout![index].interval!,
                                  author: state.workout![index].author!,
                                  description:
                                      state.workout![index].description!,
                                  recommendation:
                                      state.workout![index].recommendation!,
                                  exercises: state.workout![index].exercises!,
                                  image: state.workout![index].image!,
                                  id: state.workout![index].id!,
                                  category: state.workout![index].category!,
                                ),
                              ),
                            ).then(
                              (value) =>
                                  context.read<YourWorkoutCubit>().init(),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                SmallWorkoutPicture(
                                    image: state.workout![index].image!),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(),
                                          Container(
                                            color: AppColors.contrast,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 5),
                                              child: Text(
                                                state.workout![index].category!,
                                                style: AppTheme
                                                    .themeData.textTheme.bodyMedium!
                                                    .copyWith(
                                                    color: AppColors.white,
                                                    fontSize: 10),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                      Text(
                                        state.workout![index].name!,
                                        style: AppTheme
                                            .themeData.textTheme.bodyMedium!
                                            .copyWith(
                                                color: AppColors.contrast,
                                                fontSize: 14),
                                      ),
                                      Text(
                                        state.workout![index].description!,
                                        style: AppTheme
                                            .themeData.textTheme.bodyMedium!
                                            .copyWith(
                                                color: AppColors.contrast,
                                                fontSize: 8,
                                                fontWeight: FontWeight.w300),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            state.workout![index].interval!,
                                            style: AppTheme
                                                .themeData.textTheme.bodyMedium!
                                                .copyWith(
                                                    color: AppColors.contrast,
                                                    fontSize: 8),
                                          ),
                                          Text(
                                            state.workout![index].author!,
                                            style: AppTheme
                                                .themeData.textTheme.bodyMedium!
                                                .copyWith(
                                                    color: AppColors.disabled,
                                                    fontSize: 8),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
