import 'package:flutter/material.dart';

import '../../../common/constants/colors.dart';
import '../../../common/constants/constants.dart';
import '../../../common/constants/icons.dart';
import '../../../common/themes/theme.dart';
import '../../../data/models/group.dart';
import '../../widgets/big_workout_picture.dart';

class TrainingScreen extends StatelessWidget {
  final String header;
  final String interval;
  final String author;
  final String description;
  final String recommendation;
  final String image;
  final List<Group> exercises;

  const TrainingScreen({
    Key? key,
    required this.header,
    required this.interval,
    required this.author,
    required this.description,
    required this.recommendation,
    required this.image,
    required this.exercises,
  }) : super(key: key);

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Text(
              header,
              style: AppTheme.themeData.textTheme.displayMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: BigWorkoutPicture(image: image),
            ),
            Text(
              description,
              style: AppTheme.themeData.textTheme.labelSmall,
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  interval,
                  style: AppTheme.themeData.textTheme.displayMedium!
                      .copyWith(fontSize: 8),
                ),
                Text(
                  author,
                  style: AppTheme.themeData.textTheme.displayMedium!
                      .copyWith(fontSize: 8, color: AppColors.active),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                AppText.exercises,
                style: AppTheme.themeData.textTheme.labelLarge,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: exercises.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      exercises[index].exercise == null
                          ? const SizedBox()
                          : Row(
                              children: [
                                SizedBox(
                                  height: 65,
                                  width: 65,
                                  child: Image.asset(
                                    exercises[index].exercise!.image!,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      exercises[index].exercise!.name!,
                                      style: AppTheme
                                          .themeData.textTheme.bodyMedium!
                                          .copyWith(
                                              color: AppColors.contrast,
                                              fontSize: 12),
                                    ),
                                    Text(
                                      '${exercises[index].exercise!.duration!} ${exercises[index].exercise!.timeValue!}',
                                      style: AppTheme
                                          .themeData.textTheme.bodyMedium!
                                          .copyWith(
                                              color: AppColors.contrast,
                                              fontSize: 8),
                                    ),
                                  ],
                                )
                              ],
                            ),
                      exercises[index].relaxTime == 'null' ||
                              exercises[index].relaxTime == null
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                '${AppText.relax} ${exercises[index].relaxTime!} ${AppText.seconds}',
                                style: AppTheme
                                    .themeData.textTheme.displayMedium!
                                    .copyWith(fontSize: 12),
                              ),
                            ),
                    ],
                  );
                }),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 5,
              ),
              child: Text(
                AppText.mealsRecommendations,
                style: AppTheme.themeData.textTheme.labelLarge,
              ),
            ),
            Text(
              recommendation,
              style: AppTheme.themeData.textTheme.displayMedium!
                  .copyWith(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
