import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifestyle/common/constants/colors.dart';
import 'package:lifestyle/presentation/bloc/home/health_directory/health_cubit.dart';
import 'package:lifestyle/presentation/widgets/big_workout_picture.dart';
import 'package:lifestyle/presentation/widgets/loading_indicator.dart';
import 'package:lifestyle/presentation/widgets/small_workout_picture.dart';

import '../../../common/constants/constants.dart';
import '../../../common/services/service_locator.dart';
import '../../../common/themes/theme.dart';

class HealthDirectory extends StatelessWidget {
  const HealthDirectory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HealthCubit>(),
      child: Scaffold(
        body: BlocBuilder<HealthCubit, HealthState>(
          builder: (context, state) {
            if (state.status!.isLoading) {
              return const LoadingIndicator();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    height: 20,
                    color: AppColors.whiteShade,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppText.forToday,
                          style: AppTheme.themeData.textTheme.displayMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: BigWorkoutPicture(image: state.files![0].thumbnail!),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.files![0].name!,
                              style: AppTheme.themeData.textTheme.displayMedium,
                            ),
                            Text(
                              'Video time',
                              style: AppTheme.themeData.textTheme.displayMedium,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            AppText.neww,
                            style: AppTheme.themeData.textTheme.displayMedium!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        mock(state.files![1].thumbnail!, state.files![1].name!, '1:23'),
                        const SizedBox(
                          height: 20,
                        ),
                        mock(state.files![2].thumbnail!, state.files![2].name!,
                            '7:55'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            AppText.articles,
                            style: AppTheme.themeData.textTheme.displayMedium!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        mock(state.files![3].thumbnail!, state.files![3].name!, '2:3'),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Row mock(String image, String name, String time) {
    return Row(
      children: [
        SmallWorkoutPicture(image: image),
        const SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: AppTheme.themeData.textTheme.bodyMedium!
                  .copyWith(color: AppColors.contrast, fontSize: 14),
            ),
            Text(
              time,
              style: AppTheme.themeData.textTheme.bodyMedium!
                  .copyWith(color: AppColors.contrast, fontSize: 14),
            ),
          ],
        )
      ],
    );
  }
}
