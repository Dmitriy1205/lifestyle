import 'package:flutter/material.dart';
import 'package:lifestyle/common/constants/colors.dart';

import '../../common/constants/constants.dart';
import '../../common/themes/theme.dart';

class CreateProfileBody extends StatelessWidget {
  final String title;
  final Widget? content;
  final Future<void> Function()? onTapNext;
  final Function()? onTapPrev;
  final String buttonTitle;
  final bool isFirst;

  const CreateProfileBody({
    Key? key,
    required this.title,
    this.content,
    required this.buttonTitle,
    this.onTapNext,
    this.onTapPrev,
    this.isFirst = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 90,
            ),
            Text(
              title,
              style: AppTheme.themeData.textTheme.displayLarge,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 0,
                right: 10,
              ),
              child: content,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: onTapNext,
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 18,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    buttonTitle,
                    style: AppTheme.themeData.textTheme.titleLarge,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            !isFirst
                ? SizedBox(
                    height: 48,
                  )
                : TextButton(
                    onPressed: onTapPrev,
                    child: Text(
                      AppText.previousStep,
                      style: AppTheme.themeData.textTheme.labelMedium!
                          .copyWith(color: AppColors.contrast),
                    ),
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 60,
            ),
          ],
        ),
      ),
    );
  }
}
