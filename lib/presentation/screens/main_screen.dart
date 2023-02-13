import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/common/constants/constants.dart';
import 'package:lifestyle/common/constants/icons.dart';
import 'package:lifestyle/presentation/screens/feed.dart';
import 'package:lifestyle/presentation/screens/profile.dart';

import '../../common/constants/colors.dart';
import 'home_screen/home.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> _pages = <Widget>[
    Home(),
    Feed(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.disabled,
                blurRadius: 8,
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            unselectedItemColor: AppColors.disabled,
            selectedItemColor: AppColors.active,
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 20,right: 5),
                  child: Icon(AppIcons.home),
                ),
                label: AppText.home,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                  ),
                ),
                label: AppText.feed,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Icon(AppIcons.user),
                ),
                label: AppText.profile,
              ),
            ],
          ),
        ),
        body: Container(
          child: Center(
            child: _pages.elementAt(_selectedIndex),
          ),
        ),
      ),
    );
  }
}
