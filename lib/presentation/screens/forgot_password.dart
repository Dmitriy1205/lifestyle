import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/common/constants/colors.dart';
import 'package:lifestyle/common/utils/validator.dart';
import 'package:lifestyle/presentation/bloc/reset_password/reset_password_cubit.dart';
import 'package:lifestyle/presentation/screens/sign_in.dart';

import '../../common/constants/constants.dart';
import '../../common/constants/icons.dart';
import '../../common/services/service_locator.dart';
import '../../common/themes/theme.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ResetPasswordCubit>(),
      child: Scaffold(
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
        body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if (state.status!.isError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 5),
                  content: Text(
                    state.status!.errorMessage.toString(),
                  ),
                ),
              );
            } else if (state.status!.isLoaded) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => SignIn()));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.green,
                  duration: Duration(seconds: 5),
                  content: Text(
                    'Check your Email',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.status!.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainAccent,
                ),
              );
            }
            return SafeArea(
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
                            controller: _emailController,
                            style: AppTheme.themeData.textTheme.displayMedium,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              hintText: AppText.email,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, bottom: 10, top: 13),
                                child: FaIcon(
                                  FontAwesomeIcons.solidEnvelope,
                                ),
                              ),
                            ),
                            validator: context.validateEmailAddress,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        _formKey.currentState!.save();
                        context
                            .read<ResetPasswordCubit>()
                            .send(_emailController.text);
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
            );
          },
        ),
      ),
    );
  }
}
