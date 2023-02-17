import 'package:flutter/material.dart';
import 'package:lifestyle/common/themes/theme.dart';

import '../../common/constants/constants.dart';

class Feed extends StatelessWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          AppText.feed,
          style: AppTheme.themeData.textTheme.displayLarge,
        ),
      ),
    );
  }
}
