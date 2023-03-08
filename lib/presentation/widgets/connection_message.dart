import 'package:flutter/material.dart';

import '../../common/constants/colors.dart';
import '../../common/constants/constants.dart';

class ConnectionMessage {
  ConnectionMessage._();

  static buildErrorSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: AppColors.red,
      content: Text(
        AppText.checkYourConnection,
        textAlign: TextAlign.center,
      ),
    ));
  }
}
