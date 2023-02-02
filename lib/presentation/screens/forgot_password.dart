import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/common/constants/colors.dart';

import '../../common/constants/constants.dart';
import '../../common/constants/icons.dart';
import '../../common/themes/theme.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            AppIcons.back,
            color: AppColors.contrast,
            size: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 10),
                child: Text(
                  AppText.forgotPassword.toUpperCase(),
                  style: AppTheme.themeData.textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 70),
                child: Text(
                  AppText.weWillSendLink,
                  style: AppTheme.themeData.textTheme.displayMedium,
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: AppTheme.themeData.textTheme.displayMedium,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        hintText: AppText.email,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, bottom: 10, top: 13),
                          child: FaIcon(
                            FontAwesomeIcons.solidEnvelope,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  //TODO: route to home screen
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 18,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      AppText.sendEmail,
                      style: AppTheme.themeData.textTheme.titleLarge,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
