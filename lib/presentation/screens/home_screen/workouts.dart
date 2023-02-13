import 'package:flutter/material.dart';
import 'package:lifestyle/presentation/screens/home_screen/training_screen.dart';

import '../../../common/constants/colors.dart';
import '../../../common/constants/constants.dart';
import '../../../common/themes/theme.dart';
import '../../../data/models/workout.dart';

class Workouts extends StatelessWidget {
  const Workouts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              padding: const EdgeInsets.only(left: 20, right: 30, top: 20),
              child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppText.forYou,
                    style: AppTheme.themeData.textTheme.displayMedium!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => TrainingScreen(
                                    header: items[index].name!,
                                    interval: items[index].interval!,
                                    author: items[index].author!,
                                    description: items[index].description!,
                                    recommendation:
                                        '''During training you should consume great amount of creatine,
which can be taken from chicken or fat food or pure creating
powder.''',
                                  ),
                                ),
                              );
                            },
                            child: mock(
                              items[index].image!,
                              items[index].name!,
                              items[index].interval!,
                              items[index].author!,
                              items[index].description!,
                            ),
                          ),
                        );
                      }),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Workout> items = [
  Workout(
      name: 'Gym 5-4-3-4-5 training',
      description:
          '''Make intensification for your training, prepare your body for new results or upcoming competitions''',
      interval: '10 trainings  | 8:40',
      image: AppText.train2,
      author: 'Mitchel Gilart'),
  Workout(
      name: 'Gym 4-4 training',
      description:
          '''Training helps you to recover from injury or keep your form stable''',
      interval: '8 trainings | 6:50',
      image: AppText.train3,
      author: 'Mitchel Gilart'),
  Workout(
      name: 'Gym 4-4 training',
      description:
          '''Training helps you to recover from injury or keep your form stable''',
      interval: '8 trainings | 6:50',
      image: AppText.train3,
      author: 'Mitchel Gilart'),
];

Row mock(String image, String name, String interval, String author,
    String description) {
  return Row(
    children: [
      Container(
        height: 65,
        width: 65,
        child: Image.asset(
          image,
        ),
      ),
      SizedBox(
        width: 15,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: AppTheme.themeData.textTheme.bodyMedium!
                  .copyWith(color: AppColors.contrast, fontSize: 14),
            ),
            Text(
              description,
              style: AppTheme.themeData.textTheme.bodyMedium!.copyWith(
                  color: AppColors.contrast,
                  fontSize: 8,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  interval,
                  style: AppTheme.themeData.textTheme.bodyMedium!
                      .copyWith(color: AppColors.contrast, fontSize: 8),
                ),
                Text(
                  author,
                  style: AppTheme.themeData.textTheme.bodyMedium!
                      .copyWith(color: AppColors.disabled, fontSize: 8),
                ),
              ],
            ),
          ],
        ),
      )
    ],
  );
}
