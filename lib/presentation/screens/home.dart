import 'package:flutter/material.dart';
import 'package:lifestyle/common/themes/theme.dart';

import '../../common/constants/constants.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            AppText.home,
            style: AppTheme.themeData.textTheme.displayLarge,
          ),
        ),
      ),
    );
  }
}
