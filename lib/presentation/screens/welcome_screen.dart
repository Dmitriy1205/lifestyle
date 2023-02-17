import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifestyle/presentation/bloc/welcome/welcome_cubit.dart';
import 'package:lifestyle/presentation/screens/sign_in.dart';
import 'package:lifestyle/presentation/widgets/loading_indicator.dart';
import 'package:video_player/video_player.dart';

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
              child: state.controller!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: state.controller!.value.aspectRatio,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          VideoPlayer(state.controller!),
                          Positioned(
                            bottom: MediaQuery.of(context).size.height / 8,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.3,
                              height: MediaQuery.of(context).size.height / 16,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    context.read<WelcomeCubit>().close();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const SignIn(),
                                      ),
                                    );
                                  },
                                  child: const Text('Start')),
                            ),
                          )
                        ],
                      ),
                    )
                  : const SizedBox(),
            );
          }
          return const LoadingIndicator();
        },
      ),
    );
  }
}
