import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/common/constants/colors.dart';
import 'package:lifestyle/presentation/bloc/video_player/video_player_cubit.dart';
import 'package:lifestyle/presentation/widgets/loading_indicator.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String video;

  const VideoPlayerScreen({
    super.key,
    required this.video,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  void initState() {
    context.read<VideoPlayerCubit>().init(widget.video);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
        builder: (context, state) {
          if (state.status!.isLoading) {
            return const LoadingIndicator();
          }
          return Center(
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: state.controller!.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(state.controller!),
                ),
                Positioned(
                  bottom: 45,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: VideoProgressIndicator(
                        state.controller!,
                        allowScrubbing: true,
                        colors: const VideoProgressColors(
                            playedColor: AppColors.mainAccent),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: IconButton(
                    onPressed: () {
                      state.isPlaying!
                          ? context
                              .read<VideoPlayerCubit>()
                              .playPause(!state.isPlaying!)
                          : context
                              .read<VideoPlayerCubit>()
                              .playPause(!state.isPlaying!);
                    },
                    icon: FaIcon(
                      !state.isPlaying!
                          ? FontAwesomeIcons.pause
                          : FontAwesomeIcons.play,
                      color: AppColors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      state.isFullScreen!
                          ? context
                              .read<VideoPlayerCubit>()
                              .fullScreen(!state.isFullScreen!)
                          : context
                              .read<VideoPlayerCubit>()
                              .fullScreen(!state.isFullScreen!);
                    },
                    icon: FaIcon(
                      !state.isFullScreen!
                          ? FontAwesomeIcons.maximize
                          : FontAwesomeIcons.minimize,
                      color: AppColors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 10,
                  child: IconButton(
                    onPressed: () {
                      context.read<VideoPlayerCubit>().setAllOrientation();
                      Navigator.pop(context);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.xmark,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
