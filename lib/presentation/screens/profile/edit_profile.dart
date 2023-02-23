import 'package:flutter/material.dart';

import '../../../common/constants/colors.dart';
import '../../../common/constants/constants.dart';
import '../../../common/constants/icons.dart';
import '../../../common/themes/theme.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

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
          AppText.editProfile.toUpperCase(),
          style: AppTheme.themeData.textTheme.displayLarge,
        ),
      ),
      body: Container(),
    );
  }
}
