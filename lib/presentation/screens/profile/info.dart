import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/common/constants/constants.dart';
import 'package:lifestyle/common/constants/icons.dart';
import 'package:lifestyle/common/themes/theme.dart';

import '../../../common/constants/colors.dart';

class Info extends StatelessWidget {
  final String? userEmail;

  const Info({Key? key, this.userEmail}) : super(key: key);

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
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () {
                  //TODO: make apply data
                },
                icon: const FaIcon(
                  FontAwesomeIcons.check,
                  color: AppColors.green,
                ),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 150,
                  width: 175,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: AppColors.white,
                        child: Image.asset('assets/images/user.png'),
                      ),
                      const Positioned(
                        right: 0,
                        bottom: 5,
                        child: CircleAvatar(
                          backgroundColor: AppColors.contrast,
                          radius: 30,
                          child: Icon(
                            Icons.photo_camera,
                            color: AppColors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                AppText.username,
                style: AppTheme.themeData.textTheme.displayMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                initialValue: userEmail,
                style: AppTheme.themeData.textTheme.displayMedium,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  hintText: AppText.email,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
