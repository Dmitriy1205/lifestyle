import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/common/constants/constants.dart';
import 'package:lifestyle/common/constants/icons.dart';
import 'package:lifestyle/presentation/screens/feed.dart';
import 'package:lifestyle/presentation/screens/profile/profile.dart';

import '../../common/constants/colors.dart';
import 'home_screen/home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    const Home(),
    const Feed(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
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
            selectedItemColor: AppColors.contrast,
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 20,right: 5),
                  child: Icon(AppIcons.home),
                ),
                label: AppText.home,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                  ),
                ),
                label: AppText.feed,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Icon(AppIcons.user),
                ),
                label: AppText.profile,
              ),
            ],
          ),
        ),
        body: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}
