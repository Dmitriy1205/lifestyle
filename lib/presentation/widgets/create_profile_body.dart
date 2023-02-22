import 'package:flutter/material.dart';
import 'package:lifestyle/common/constants/colors.dart';

import '../../common/constants/constants.dart';
import '../../common/constants/icons.dart';
import '../../common/themes/theme.dart';

class CreateProfileBody extends StatelessWidget {
  final String title;
  final Widget? content;
  final Future<void> Function()? onTapNext;
  final Future<void> Function()? onEdit;
  final Function()? onTapPrev;
  final String buttonTitle;
  final bool isFirst;
  final bool fromProfile;

  const CreateProfileBody({
    Key? key,
    required this.title,
    this.content,
    required this.buttonTitle,
    this.onTapNext,
    this.onTapPrev,
    this.isFirst = true,
    this.fromProfile = false,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            !fromProfile
                ? const SizedBox(
                    height: 90,
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 60, bottom: 40),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: IconButton(
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
            const Spacer(),
            !fromProfile
                ? ElevatedButton(
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
                  )
                : ElevatedButton(
                    onPressed: onEdit,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 18,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          AppText.edit,
                          style: AppTheme.themeData.textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 15,
            ),
            !isFirst
                ? const SizedBox(
                    height: 48,
                  )
                : !fromProfile
                    ? TextButton(
                        onPressed: onTapPrev,
                        child: Text(
                          AppText.previousStep,
                          style: AppTheme.themeData.textTheme.labelMedium!
                              .copyWith(color: AppColors.contrast),
                        ),
                      )
                    : const SizedBox(
                        height: 48,
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
