import 'package:flutter/material.dart';
import 'package:lifestyle/common/constants/colors.dart';

import '../../../common/constants/constants.dart';
import '../../../common/themes/theme.dart';

class HealthDirectory extends StatelessWidget {
  const HealthDirectory({Key? key}) : super(key: key);

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
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                physics: ClampingScrollPhysics(),
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
                    child: Container(
                      child: Image.asset(AppText.train1),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Video name',
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
                  mock(AppText.train2, 'Push-ups together', '1:23'),
                  SizedBox(
                    height: 20,
                  ),
                  mock(AppText.train3, 'Basic heavy weights tecniques', '7:55'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      AppText.articles,
                      style: AppTheme.themeData.textTheme.displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  mock(AppText.train2, 'Article', 'Push-ups together'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row mock(String image, String name, String time) {
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
