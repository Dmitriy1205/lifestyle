import 'package:flutter/material.dart';

import '../../common/constants/colors.dart';
import '../../common/constants/constants.dart';

class ConnectionMessage {
  ConnectionMessage._();

  static buildDisconnectedSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.red,
        content: Text(
          AppText.checkYourConnection,
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  static buildConnectedSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.green,
        content: Text(
          AppText.connected,
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
