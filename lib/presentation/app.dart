import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifestyle/common/themes/theme.dart';
import 'package:lifestyle/presentation/bloc/auth/auth_cubit.dart';
import 'package:lifestyle/presentation/screens/main_screen.dart';
import 'package:lifestyle/presentation/screens/sign_in.dart';
import 'package:lifestyle/presentation/screens/sign_up.dart';

import '../common/services/service_locator.dart';
import 'bloc/sign_in/sign_in_cubit.dart';
import 'bloc/sign_up/sign_up_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<SignUpCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<SignInCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state.isSignedIn == false) {
              return SignUp();
            }
            return MainScreen();
          },
        ),
      ),
    );
  }
}
