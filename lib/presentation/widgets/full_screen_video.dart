import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/common/constants/colors.dart';
import 'package:lifestyle/presentation/bloc/home/health_directory/health_cubit.dart';
import 'package:video_player/video_player.dart';

class FullScreen extends StatefulWidget {
  final VideoPlayerController controller;
  final bool isPlaying;

  const FullScreen({
    super.key,
    required this.controller,
    required this.isPlaying,
  });

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  void initState() {
    BlocProvider.of<HealthCubit>(context).landscapeMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<HealthCubit, HealthState>(
        builder: (context, state) {
          return Center(
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: widget.controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(widget.controller),
                ),
                Positioned(
                  bottom: 45,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: VideoProgressIndicator(
                        widget.controller,
                        allowScrubbing: true,
                        colors: const VideoProgressColors(
                          playedColor: AppColors.mainAccent,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: IconButton(
                    icon: FaIcon(
                      !widget.isPlaying
                          ? FontAwesomeIcons.pause
                          : FontAwesomeIcons.play,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      widget.isPlaying
                          ? BlocProvider.of<HealthCubit>(context)
                              .playPause(!widget.isPlaying)
                          : BlocProvider.of<HealthCubit>(context)
                              .playPause(!widget.isPlaying);
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      BlocProvider.of<HealthCubit>(context).setAllOrientation();
                      Navigator.pop(context);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.minimize,
                      color: AppColors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 10,
                  child: IconButton(
                    onPressed: () {
                      BlocProvider.of<HealthCubit>(context).setAllOrientation();
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
