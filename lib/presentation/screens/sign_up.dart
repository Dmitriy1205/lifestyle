import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/common/constants/colors.dart';
import 'package:lifestyle/common/utils/validator.dart';
import 'package:lifestyle/presentation/bloc/sign_up/sign_up_cubit.dart';
import 'package:lifestyle/presentation/screens/create_profile/create_profile.dart';
import 'package:lifestyle/presentation/screens/sign_in.dart';

import '../../common/constants/constants.dart';
import '../../common/themes/theme.dart';
import '../widgets/loading_indicator.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const CreateProfile()));
              } else if (state.status!.isError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.red,
                    duration: const Duration(seconds: 5),
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
                return const LoadingIndicator();
              }
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const Spacer(),
                      Text(
                        AppText.createAccount,
                        style: AppTheme.themeData.textTheme.displayLarge,
                      ),
                      Text(
                        AppText.greatOpportunity,
                        style: AppTheme.themeData.textTheme.displayMedium,
                      ),
                      const Spacer(),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              style: AppTheme.themeData.textTheme.displayMedium,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                hintText: AppText.email,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
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
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: state.isPassObscure,
                              style: AppTheme.themeData.textTheme.displayMedium,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                hintText: AppText.password,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 12, bottom: 10, top: 12),
                                  child: FaIcon(
                                    FontAwesomeIcons.lock,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    state.isPassObscure
                                        ? context
                                            .read<SignUpCubit>()
                                            .showPass(!state.isPassObscure)
                                        : context
                                            .read<SignUpCubit>()
                                            .showPass(!state.isPassObscure);
                                  },
                                  icon: state.isPassObscure
                                      ? const FaIcon(
                                          FontAwesomeIcons.eye,
                                          color: AppColors.disabled,
                                        )
                                      : const FaIcon(
                                          FontAwesomeIcons.solidEye,
                                        ),
                                ),
                              ),
                              validator: context.validateFieldNotEmpty,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: state.isConfPassObscure,
                              style: AppTheme.themeData.textTheme.displayMedium,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                hintText: AppText.confirmPassword,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 12, bottom: 10, top: 12),
                                  child: FaIcon(
                                    FontAwesomeIcons.lock,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    state.isConfPassObscure
                                        ? context
                                            .read<SignUpCubit>()
                                            .showConfirmPass(
                                                !state.isConfPassObscure)
                                        : context
                                            .read<SignUpCubit>()
                                            .showConfirmPass(
                                                !state.isConfPassObscure);
                                  },
                                  icon: state.isConfPassObscure
                                      ? const FaIcon(
                                          FontAwesomeIcons.eye,
                                          color: AppColors.disabled,
                                        )
                                      : const FaIcon(
                                          FontAwesomeIcons.solidEye,
                                        ),
                                ),
                              ),
                              validator: (value) {
                                if (value != _passwordController.text) {
                                  return 'Enter Valid Password';
                                }
                                if (value!.isEmpty) {
                                  return 'Field cannot be empty';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const Spacer(
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
                        child: SizedBox(
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
                                  const TextSpan(
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
                                              builder: (context) => const SignIn(),
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
