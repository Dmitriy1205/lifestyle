import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/common/constants/colors.dart';
import 'package:lifestyle/common/themes/theme.dart';
import 'package:lifestyle/presentation/screens/home_screen/health_directory.dart';
import 'package:lifestyle/presentation/screens/home_screen/workouts.dart';

import '../../../common/constants/constants.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppText.lifestyle,
            style: AppTheme.themeData.textTheme.displayLarge,
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 26,
                ),
              ),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: AppColors.mainAccent,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 30),
            indicatorWeight: 3,
            labelPadding: EdgeInsets.symmetric(vertical: 10),
            tabs: [
              Text(
                AppText.healthDirectory,
              ),
              Text(
                AppText.goals,
              )
            ],
          ),
        ),
        body: Column(
          children:  [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 20,
                color: AppColors.whiteShade,
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  HealthDirectory(),
                  Workouts(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
