import 'package:flutter/material.dart';

import '../../../common/constants/colors.dart';
import '../../../common/constants/constants.dart';
import '../../../common/constants/icons.dart';
import '../../../common/themes/theme.dart';

class TrainingScreen extends StatelessWidget {
  final String header;
  final String interval;
  final String author;
  final String description;
  final String recommendation;

  const TrainingScreen({
    Key? key,
    required this.header,
    required this.interval,
    required this.author,
    required this.description,
    required this.recommendation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            AppIcons.back,
            color: AppColors.contrast,
            size: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Text(
              header,
              style: AppTheme.themeData.textTheme.displayMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Container(
                child: Image.asset(AppText.train5),
              ),
            ),
            Text(
              description,
              style: AppTheme.themeData.textTheme.labelSmall,
              textAlign: TextAlign.start,
            ),
            SizedBox(
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
            SizedBox(
              height: 10,
            ),
            //todo: put listview.builder for exercises instead of rows from here
            Row(
              children: [
                Container(
                  height: 65,
                  width: 65,
                  child: Image.asset(
                    AppText.excercise1,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jumps on height',
                      style: AppTheme.themeData.textTheme.bodyMedium!
                          .copyWith(color: AppColors.contrast, fontSize: 12),
                    ),
                    Text(
                      '30 Seconds',
                      style: AppTheme.themeData.textTheme.bodyMedium!
                          .copyWith(color: AppColors.contrast, fontSize: 8),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Relax 20 Seconds',
                style: AppTheme.themeData.textTheme.displayMedium!
                    .copyWith(fontSize: 12),
              ),
            ),
            Row(
              children: [
                Container(
                  height: 65,
                  width: 65,
                  child: Image.asset(
                    AppText.excercise1,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jumps on height',
                      style: AppTheme.themeData.textTheme.bodyMedium!
                          .copyWith(color: AppColors.contrast, fontSize: 14),
                    ),
                    Text(
                      '30 Seconds',
                      style: AppTheme.themeData.textTheme.bodyMedium!
                          .copyWith(color: AppColors.contrast, fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Relax 20 Seconds',
                style: AppTheme.themeData.textTheme.displayMedium!
                    .copyWith(fontSize: 12),
              ),
            ),
            Row(
              children: [
                Container(
                  height: 65,
                  width: 65,
                  child: Image.asset(
                    AppText.excercise1,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jumps on height',
                      style: AppTheme.themeData.textTheme.bodyMedium!
                          .copyWith(color: AppColors.contrast, fontSize: 14),
                    ),
                    Text(
                      '30 Seconds',
                      style: AppTheme.themeData.textTheme.bodyMedium!
                          .copyWith(color: AppColors.contrast, fontSize: 14),
                    ),
                  ],
                )
              ],
            ),

            //todo: until this
            Padding(
              padding: const EdgeInsets.only(
                top: 40,
                bottom: 5,
              ),
              child: Text(
                AppText.mealsRecomendations,
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
// ListView.builder(
//   shrinkWrap: true,
//   itemBuilder: (BuildContext context, int index) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Container(
//               height: 65,
//               width: 65,
//               child: Image.asset(
//                 AppText.excercise1,
//               ),
//             ),
//             SizedBox(
//               width: 15,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Jumps on height',
//                   style: AppTheme.themeData.textTheme.bodyMedium!
//                       .copyWith(
//                           color: AppColors.contrast, fontSize: 12),
//                 ),
//                 Text(
//                   '30 Seconds',
//                   style: AppTheme.themeData.textTheme.bodyMedium!
//                       .copyWith(
//                           color: AppColors.contrast, fontSize: 8),
//                 ),
//               ],
//             )
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20),
//           child: Text(
//             'Relax 20 Seconds',
//             style: AppTheme.themeData.textTheme.displayMedium!
//                 .copyWith(fontSize: 12),
//           ),
//         ),
//       ],
//     );
//   },
// )
