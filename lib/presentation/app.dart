import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifestyle/common/themes/theme.dart';
import 'package:lifestyle/presentation/bloc/auth/auth_cubit.dart';
import 'package:lifestyle/presentation/bloc/welcome/welcome_cubit.dart';
import 'package:lifestyle/presentation/screens/main_screen.dart';
import 'package:lifestyle/presentation/screens/welcome_screen.dart';

import '../common/services/service_locator.dart';
import 'bloc/home/health_directory/health_cubit.dart';
import 'bloc/home/home_cubit.dart';
import 'bloc/profile/create_workout/create_workout_cubit.dart';
import 'bloc/profile/edit_workout/edit_workout_cubit.dart';
import 'bloc/profile/your_workout/your_workout_cubit.dart';
import 'bloc/sign_in/sign_in_cubit.dart';
import 'bloc/sign_up/sign_up_cubit.dart';
import 'bloc/video_player/video_player_cubit.dart';

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
        BlocProvider(
          create: (context) => sl<WelcomeCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<CreateWorkoutCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<YourWorkoutCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<EditWorkoutCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<HealthCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<VideoPlayerCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<HomeCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            // return CreateProfile();
            if (state.isSignedIn == false) {
              return const WelcomeScreen();
            }
            return const MainScreen();
          },
        ),
      ),
    );
  }
}
