import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/common/constants/colors.dart';
import 'package:lifestyle/common/utils/validator.dart';
import 'package:lifestyle/presentation/bloc/sign_up/sign_up_cubit.dart';
import 'package:lifestyle/presentation/screens/main_screen.dart';
import 'package:lifestyle/presentation/screens/sign_in.dart';

import '../../common/constants/constants.dart';
import '../../common/themes/theme.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state.status!.isLoaded) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => MainScreen()));
              } else if (state.status!.isError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.red,
                    duration: Duration(seconds: 5),
                    content: Text(
                      state.status!.errorMessage.toString(),
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
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Spacer(),
                      Text(
                        AppText.createAccount,
                        style: AppTheme.themeData.textTheme.displayLarge,
                      ),
                      Text(
                        AppText.greatOpportunity,
                        style: AppTheme.themeData.textTheme.displayMedium,
                      ),
                      Spacer(),
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
                                    left: 12,
                                    bottom: 10,
                                    top: 13,
                                  ),
                                  child: FaIcon(
                                    FontAwesomeIcons.solidEnvelope,
                                  ),
                                ),
                              ),
                              validator: context.validateEmailAddress,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: state.isObscure,
                              style: AppTheme.themeData.textTheme.displayMedium,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                hintText: AppText.password,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, bottom: 10, top: 12),
                                  child: FaIcon(
                                    FontAwesomeIcons.lock,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    if (state.isObscure) {
                                      context
                                          .read<SignUpCubit>()
                                          .showPass(false);
                                    } else if (!state.isObscure) {
                                      context
                                          .read<SignUpCubit>()
                                          .showPass(true);
                                    }
                                  },
                                  icon: state.isObscure
                                      ? FaIcon(
                                          FontAwesomeIcons.eye,
                                          color: AppColors.disabled,
                                        )
                                      : FaIcon(
                                          FontAwesomeIcons.solidEye,
                                        ),
                                ),
                              ),
                              validator: context.validateFieldNotEmpty,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _confirmPasswordController,
                              style: AppTheme.themeData.textTheme.displayMedium,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                hintText: AppText.confirmPassword,
                                prefixIcon: SizedBox(),
                              ),
                              validator: (value) {
                                if (value != _passwordController.text) {
                                  return 'Enter Valid Password';
                                }
                                if (value!.isEmpty)
                                  return 'Email cannot be empty';
                              },
                            ),
                          ],
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          _formKey.currentState!.save();
                          context.read<SignUpCubit>().signUp(
                                _emailController.text,
                                _passwordController.text,
                              );
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 16,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              AppText.signUp,
                              style: AppTheme.themeData.textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                style:
                                    AppTheme.themeData.textTheme.displayMedium,
                                children: [
                                  TextSpan(
                                      text: AppText.haveAccount,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  TextSpan(
                                      text: AppText.signIn,
                                      style: AppTheme
                                          .themeData.textTheme.labelMedium,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SignIn(),
                                            ),
                                          );
                                        }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
