import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifestyle/presentation/bloc/welcome/welcome_cubit.dart';
import 'package:lifestyle/presentation/screens/sign_up.dart';
import 'package:video_player/video_player.dart';

import '../../common/constants/colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WelcomeCubit, WelcomeState>(
        builder: (context, state) {
          if (state.controller != null && state.isPlaying == true) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SignUp(),
                    ),
                  );
                  context.read<WelcomeCubit>().close();
                },
                child: state.controller!.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: state.controller!.value.aspectRatio,
                        child: VideoPlayer(state.controller!),
                      )
                    : SizedBox(),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.mainAccent,
            ),
          );
        },
      ),
    );
  }
}
