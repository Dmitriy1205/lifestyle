import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/presentation/bloc/home/workout/workout_cubit.dart';
import 'package:lifestyle/presentation/screens/home_screen/training_screen.dart';

import '../../../common/constants/colors.dart';
import '../../../common/constants/constants.dart';
import '../../../common/services/service_locator.dart';
import '../../../common/themes/theme.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/small_workout_picture.dart';

class Workouts extends StatefulWidget {
  const Workouts({Key? key}) : super(key: key);

  @override
  State<Workouts> createState() => _WorkoutsState();
}

class _WorkoutsState extends State<Workouts>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => sl<WorkoutCubit>(),
      child: Scaffold(
        body: BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (context, state) {
            if (state.status!.isLoading) {
              return const LoadingIndicator();
            }
            return RefreshIndicator(
              backgroundColor: AppColors.whiteShade,
              strokeWidth: 3,
              onRefresh: () async {

                await context.read<WorkoutCubit>().refresh();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 30, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 35,
                            width: 125,
                            decoration: BoxDecoration(
                                color: AppColors.contrast,
                                border: Border.all(color: AppColors.white),
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: DropdownButton(
                                dropdownColor: AppColors.contrast,
                                alignment: AlignmentDirectional.center,
                                value: state.value,
                                icon: const Padding(
                                  padding: EdgeInsets.only(left: 40),
                                  child: FaIcon(
                                    FontAwesomeIcons.angleDown,
                                    size: 14,
                                    color: AppColors.white,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(10),
                                underline: const SizedBox(),
                                items: [
                                  DropdownMenuItem(
                                    value: AppText.all,
                                    child: Text(
                                      AppText.all,
                                      style: AppTheme
                                          .themeData.textTheme.displayMedium!
                                          .copyWith(color: AppColors.white),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: AppText.gym,
                                    child: Text(
                                      AppText.gym,
                                      style: AppTheme
                                          .themeData.textTheme.displayMedium!
                                          .copyWith(color: AppColors.white),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: AppText.home,
                                    child: Text(
                                      AppText.home,
                                      style: AppTheme
                                          .themeData.textTheme.displayMedium!
                                          .copyWith(color: AppColors.white),
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  context
                                      .read<WorkoutCubit>()
                                      .changeValue(value);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          state.workout == null
                              ? const SizedBox()
                              : Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.workout!.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 15),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      TrainingScreen(
                                                    header: state
                                                        .workout![index].name!,
                                                    interval: state
                                                        .workout![index]
                                                        .interval!,
                                                    author: state
                                                        .workout![index]
                                                        .author!,
                                                    description: state
                                                        .workout![index]
                                                        .description!,
                                                    recommendation: state
                                                        .workout![index]
                                                        .recommendation!,
                                                    image: state
                                                        .workout![index].image!,
                                                    exercises: state
                                                        .workout![index]
                                                        .exercises!,
                                                    category: state
                                                        .workout![index]
                                                        .category!,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                SmallWorkoutPicture(
                                                  image: state
                                                      .workout![index].image!,
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const SizedBox(),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .mainAccent,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 4,
                                                                  horizontal:
                                                                      8),
                                                              child: Text(
                                                                state
                                                                    .workout![
                                                                        index]
                                                                    .category!,
                                                                style: AppTheme
                                                                    .themeData
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .contrast,
                                                                        fontSize:
                                                                            10),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        state.workout![index]
                                                            .name!,
                                                        style: AppTheme
                                                            .themeData
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .contrast,
                                                                fontSize: 14),
                                                      ),
                                                      Text(
                                                        state.workout![index]
                                                            .description!,
                                                        style: AppTheme
                                                            .themeData
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                          color: AppColors
                                                              .contrast,
                                                          fontSize: 8,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            state
                                                                .workout![index]
                                                                .interval!,
                                                            style: AppTheme
                                                                .themeData
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .contrast,
                                                                    fontSize:
                                                                        8),
                                                          ),
                                                          Text(
                                                            state
                                                                .workout![index]
                                                                .author!,
                                                            style: AppTheme
                                                                .themeData
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .disabled,
                                                                    fontSize:
                                                                        8),
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
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
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

  @override
  bool get wantKeepAlive => true;
}
