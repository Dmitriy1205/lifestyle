import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/common/constants/constants.dart';
import 'package:lifestyle/presentation/bloc/google_auth/google_auth_cubit.dart';
import 'package:lifestyle/presentation/screens/main_screen.dart';

import '../../common/constants/colors.dart';
import '../../common/services/service_locator.dart';
import '../../common/themes/theme.dart';

class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GoogleAuthCubit>(),
      child: _GoogleAuthButton(),
    );
  }
}

class _GoogleAuthButton extends StatelessWidget {
  const _GoogleAuthButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleAuthCubit, GoogleAuthState>(
      listener: (context, state) {
        if (state.status!.isLoaded) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.contrast,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: state.status!.isLoading
              ? null
              : () {
                  context.read<GoogleAuthCubit>().login();
                },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const FaIcon(FontAwesomeIcons.google, color: AppColors.white),
              state.status!.isLoading
                  ? Center(
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                          )),
                    )
                  : Text(
                      AppText.signInGoogle,
                      style: AppTheme.themeData.textTheme.bodyMedium,
                    ),
              SizedBox(
                width: 40,
              ),
            ],
          ),
        );
      },
    );
  }
}
