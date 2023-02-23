import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/common/constants/constants.dart';

import '../../../common/constants/colors.dart';
import '../../../common/constants/icons.dart';
import '../../../common/themes/theme.dart';

class Support extends StatelessWidget {
  const Support({Key? key}) : super(key: key);

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
          AppText.support.toUpperCase(),
          style: AppTheme.themeData.textTheme.displayLarge,
        ),
      ),
      body: Container(),
    );
  }
}
