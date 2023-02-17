import 'package:flutter/material.dart';
import 'package:lifestyle/presentation/screens/profile/add_training.dart';

import '../../../common/constants/colors.dart';
import '../../../common/constants/constants.dart';
import '../../../common/constants/icons.dart';
import '../../../common/themes/theme.dart';
import '../../../data/models/exercises.dart';

class ExerciseBuilder extends StatelessWidget {
  final Function(Exercises) addExercise;

  const ExerciseBuilder({Key? key, required this.addExercise})
      : super(key: key);

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
        title: Text(
          AppText.trainings,
          style: AppTheme.themeData.textTheme.displayLarge,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            TextFormField(
              style: AppTheme.themeData.textTheme.displayMedium,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                hintText: AppText.search,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // Todo: listviev.builder for getting trainign vvideo instead of listview
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTrainingScreen(
                            name: 'Jumps on height',
                            image: AppText.excercise1,
                            addExercise: addExercise,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          height: 65,
                          width: 65,
                          child: Image.asset(
                            AppText.excercise1,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jumps on height',
                              style: AppTheme.themeData.textTheme.bodyMedium!
                                  .copyWith(
                                      color: AppColors.contrast, fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTrainingScreen(
                            name: 'Jumps in sides',
                            image: AppText.excercise2,
                            addExercise: addExercise,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          height: 65,
                          width: 65,
                          child: Image.asset(
                            AppText.excercise2,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jumps in sides',
                              style: AppTheme.themeData.textTheme.bodyMedium!
                                  .copyWith(
                                      color: AppColors.contrast, fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
