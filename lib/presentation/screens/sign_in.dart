import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/common/constants/constants.dart';
import 'package:lifestyle/common/utils/validator.dart';
import 'package:lifestyle/presentation/screens/forgot_password.dart';
import 'package:lifestyle/presentation/screens/main_screen.dart';
import 'package:lifestyle/presentation/screens/sign_up.dart';
import 'package:lifestyle/presentation/widgets/google_button.dart';

import '../../common/constants/colors.dart';
import '../../common/themes/theme.dart';
import '../bloc/sign_in/sign_in_cubit.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<SignInCubit, SignInState>(
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
                        AppText.joinUs,
                        style: AppTheme.themeData.textTheme.displayLarge,
                      ),
                      Text(
                        AppText.theMostVarious,
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
                                    state.isObscure
                                        ? context
                                            .read<SignInCubit>()
                                            .showPass(!state.isObscure)
                                        : context
                                            .read<SignInCubit>()
                                            .showPass(!state.isObscure);
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ' Password cant be empty';
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30, top: 10),
                        child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  //TODO: route to forgot password
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForgotPassword(),
                                    ),
                                  );
                                },
                                child: Text(
                                  AppText.forgotPassword,
                                  style: AppTheme
                                      .themeData.textTheme.displayMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 19,
                          width: MediaQuery.of(context).size.width,
                          child: GoogleAuthButton()),
                      Spacer(
                        flex: 2,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          _formKey.currentState!.save();
                          context.read<SignInCubit>().signIn(
                                _emailController.text,
                                _passwordController.text,
                              );
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 18,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              AppText.signIn,
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
                                      text: AppText.dontHaveAccount,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  TextSpan(
                                      text: AppText.signUp,
                                      style: AppTheme
                                          .themeData.textTheme.labelMedium,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SignUp(),
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
