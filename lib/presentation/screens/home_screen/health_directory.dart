import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/common/constants/colors.dart';
import 'package:lifestyle/presentation/bloc/home/health_directory/health_cubit.dart';
import 'package:lifestyle/presentation/widgets/loading_indicator.dart';
import 'package:lifestyle/presentation/widgets/small_workout_picture.dart';
import 'package:video_player/video_player.dart';

import '../../../common/constants/constants.dart';
import '../../../common/services/service_locator.dart';
import '../../../common/themes/theme.dart';
import '../../widgets/full_screen_video.dart';
import '../video_player_screen.dart';

class HealthDirectory extends StatefulWidget {
  const HealthDirectory({Key? key}) : super(key: key);

  @override
  State<HealthDirectory> createState() => _HealthDirectoryState();
}

class _HealthDirectoryState extends State<HealthDirectory>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => sl<HealthCubit>(),
      child: Scaffold(
        body: BlocBuilder<HealthCubit, HealthState>(
          builder: (context, state) {
            if (state.status!.isLoading) {
              return const LoadingIndicator();
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppText.forToday,
                    style: AppTheme.themeData.textTheme.displayMedium!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 191,
                        width: MediaQuery.of(context).size.width,
                        child: !state.status!.isVideoLoading
                            ? state.controller == null
                                ? Center(
                                    child: Text(
                                      state.status!.errorMessage!,
                                      style: AppTheme
                                          .themeData.textTheme.titleSmall,
                                    ),
                                  )
                                : Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => VideoPlayerScreen(
                                                      video: state.controller!.dataSource)));
                                        },
                                        child: VideoPlayer(
                                          state.controller!,
                                        ),
                                      ),
                                      // Positioned(
                                      //   bottom: 45,
                                      //   child: SizedBox(
                                      //     width:
                                      //         MediaQuery.of(context).size.width,
                                      //     child: Padding(
                                      //       padding: const EdgeInsets.symmetric(
                                      //           horizontal: 10),
                                      //       child: VideoProgressIndicator(
                                      //         state.controller!,
                                      //         allowScrubbing: true,
                                      //         colors: const VideoProgressColors(
                                      //             playedColor:
                                      //                 AppColors.mainAccent),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      // Positioned(
                                      //   bottom: 0,
                                      //   left: 0,
                                      //   child: IconButton(
                                      //     onPressed: () {
                                      //       state.isPlaying!
                                      //           ? context
                                      //               .read<HealthCubit>()
                                      //               .playPause(
                                      //                   !state.isPlaying!)
                                      //           : context
                                      //               .read<HealthCubit>()
                                      //               .playPause(
                                      //                   !state.isPlaying!);
                                      //     },
                                      //     icon: FaIcon(
                                      //       !state.isPlaying!
                                      //           ? FontAwesomeIcons.pause
                                      //           : FontAwesomeIcons.play,
                                      //       color: AppColors.white,
                                      //     ),
                                      //   ),
                                      // ),
                                      // Positioned(
                                      //   bottom: 0,
                                      //   right: 0,
                                      //   child: IconButton(
                                      //     onPressed: () {
                                      //       Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //           builder: (_) => FullScreen(
                                      //             controller: state.controller!,
                                      //             isPlaying: state.isPlaying!,
                                      //           ),
                                      //         ),
                                      //       );
                                      //     },
                                      //     icon: const FaIcon(
                                      //       // !state.isFullScreen!
                                      //       FontAwesomeIcons.maximize,
                                      //       // : FontAwesomeIcons.minimize,
                                      //       color: AppColors.white,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  )
                            : const LoadingIndicator(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.name!,
                        style: AppTheme.themeData.textTheme.displayMedium,
                      ),
                      Text(
                        state.controller == null
                            ? ''
                            : videoDuration(state.controller!.value.duration),
                        style: AppTheme.themeData.textTheme.displayMedium,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      AppText.neww,
                      style: AppTheme.themeData.textTheme.displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.files!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 23),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => VideoPlayerScreen(
                                          video: state.files![index].path!)));
                            },
                            child: Row(
                              children: [
                                SmallWorkoutPicture(
                                    image: state.files![index].thumbnail!),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.files![index].name!,
                                      style: AppTheme
                                          .themeData.textTheme.bodyMedium!
                                          .copyWith(
                                              color: AppColors.contrast,
                                              fontSize: 14),
                                    ),
                                    Text(
                                      state.files![index].duration!,
                                      style: AppTheme
                                          .themeData.textTheme.bodyMedium!
                                          .copyWith(
                                              color: AppColors.contrast,
                                              fontSize: 14),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 17),
                    child: Text(
                      AppText.articles,
                      style: AppTheme.themeData.textTheme.displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.articles!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<HealthCubit>()
                                .launch(state.articles![index].path!);
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: SmallWorkoutPicture(
                              image: state.articles![index].image!,
                            ),
                            title: Text(
                              state.articles![index].name!,
                              style: AppTheme.themeData.textTheme.bodyMedium!
                                  .copyWith(
                                      color: AppColors.contrast, fontSize: 12),
                            ),
                            subtitle: Text(
                              state.articles![index].path!,
                              style: AppTheme.themeData.textTheme.bodyMedium!
                                  .copyWith(
                                      color: AppColors.contrast, fontSize: 14),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String videoDuration(Duration duration) {
    String digits(int n) => n.toString().padLeft(2, '0');
    final hours = digits(duration.inHours);
    final minutes = digits(duration.inMinutes.remainder(60));
    final seconds = digits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  bool get wantKeepAlive => true;
}
