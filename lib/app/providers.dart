import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/services/service_locator.dart';
import '../presentation/bloc/auth/auth_cubit.dart';
import '../presentation/bloc/home/health_directory/health_cubit.dart';
import '../presentation/bloc/home/home_cubit.dart';
import '../presentation/bloc/profile/create_workout/create_workout_cubit.dart';
import '../presentation/bloc/profile/edit_workout/edit_workout_cubit.dart';
import '../presentation/bloc/profile/your_workout/your_workout_cubit.dart';
import '../presentation/bloc/sign_in/sign_in_cubit.dart';
import '../presentation/bloc/sign_up/sign_up_cubit.dart';
import '../presentation/bloc/video_player/video_player_cubit.dart';
import '../presentation/bloc/welcome/welcome_cubit.dart';

class Providers extends StatelessWidget {
  final Widget child;

  const Providers({
    Key? key,
    required this.child,
  }) : super(key: key);

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
      child: child,
    );
  }
}
