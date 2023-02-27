import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/common/constants/colors.dart';
import 'package:lifestyle/presentation/bloc/home/health_directory/health_cubit.dart';
import 'package:lifestyle/presentation/screens/home_screen/description_screen.dart';
import 'package:lifestyle/presentation/widgets/loading_indicator.dart';
import 'package:lifestyle/presentation/widgets/small_workout_picture.dart';
import 'package:video_player/video_player.dart';

import '../../../common/constants/constants.dart';
import '../../../common/services/service_locator.dart';
import '../../../common/themes/theme.dart';
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
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      VideoPlayerScreen(
                                                          video: state
                                                              .controller!
                                                              .dataSource)));
                                        },
                                        child: VideoPlayer(
                                          state.controller!,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        child: IconButton(
                                          onPressed: () {
                                            state.isPlaying!
                                                ? context
                                                    .read<HealthCubit>()
                                                    .playPause(
                                                        !state.isPlaying!)
                                                : context
                                                    .read<HealthCubit>()
                                                    .playPause(
                                                        !state.isPlaying!);
                                          },
                                          icon: FaIcon(
                                            !state.isPlaying!
                                                ? FontAwesomeIcons.pause
                                                : FontAwesomeIcons.play,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
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
                  DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          child: TabBar(
                            indicatorColor: AppColors.mainAccent,
                            indicatorPadding:
                                EdgeInsets.symmetric(horizontal: 30),
                            indicatorWeight: 3,
                            labelPadding: EdgeInsets.symmetric(vertical: 10),
                            tabs: [
                              Text(
                                AppText.videos,
                              ),
                              Text(
                                AppText.articles,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 380,
                          width: MediaQuery.of(context).size.width,
                          child: TabBarView(
                            children: [
                              GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.files!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    VideoPlayerScreen(
                                                        video: state
                                                            .files![index]
                                                            .path!)));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                color: AppColors.grey,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: state
                                                      .files![index].thumbnail!,
                                                  placeholder: (context, url) =>
                                                      const LoadingIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Center(
                                                    child: FaIcon(
                                                      FontAwesomeIcons
                                                          .solidImage,
                                                      size: 20,
                                                      color: AppColors.active,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 10,
                                              left: 10,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state.files![index].name!,
                                                    style: AppTheme.themeData
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                            color:
                                                                AppColors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  Text(
                                                    state.files![index]
                                                        .duration!,
                                                    style: AppTheme.themeData
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                            color:
                                                                AppColors.white,
                                                            fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                              ListView(
                                shrinkWrap: true,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ExpansionTile(
                                      tilePadding: EdgeInsets.zero,
                                      title: Text(
                                        AppText.vitamins,
                                        style: AppTheme
                                            .themeData.textTheme.displayMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w700),
                                      ),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: state.vitamins!.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 23),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (_) =>
                                                              DescriptionScreen(
                                                            header: state
                                                                .vitamins![
                                                                    index]
                                                                .name!,
                                                            content: state
                                                                .vitamins![
                                                                    index]
                                                                .content!,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Row(
                                                      children: [
                                                        SmallWorkoutPicture(
                                                            image: state
                                                                .vitamins![
                                                                    index]
                                                                .image!),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              state
                                                                  .vitamins![
                                                                      index]
                                                                  .name!,
                                                              style: AppTheme
                                                                  .themeData
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .contrast,
                                                                      fontSize:
                                                                          14),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ExpansionTile(
                                    tilePadding: EdgeInsets.zero,
                                    title: Text(
                                      AppText.minerals,
                                      style: AppTheme
                                          .themeData.textTheme.displayMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w700),
                                    ),
                                    children: [
                                      ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: state.articles!.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<HealthCubit>()
                                                    .launch(state
                                                        .articles![index]
                                                        .path!);
                                              },
                                              child: ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                leading: SmallWorkoutPicture(
                                                  image: state
                                                      .articles![index].image!,
                                                ),
                                                title: Text(
                                                  state.articles![index].name!,
                                                  style: AppTheme.themeData
                                                      .textTheme.bodyMedium!
                                                      .copyWith(
                                                          color: AppColors
                                                              .contrast,
                                                          fontSize: 12),
                                                ),
                                                subtitle: Text(
                                                  state.articles![index].path!,
                                                  style: AppTheme.themeData
                                                      .textTheme.bodyMedium!
                                                      .copyWith(
                                                          color: AppColors
                                                              .contrast,
                                                          fontSize: 14),
                                                ),
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                  ExpansionTile(
                                    tilePadding: EdgeInsets.zero,
                                    title: Text(
                                      AppText.probiotics,
                                      style: AppTheme
                                          .themeData.textTheme.displayMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w700),
                                    ),
                                    children: [
                                      ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: state.articles!.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<HealthCubit>()
                                                    .launch(state
                                                        .articles![index]
                                                        .path!);
                                              },
                                              child: ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                leading: SmallWorkoutPicture(
                                                  image: state
                                                      .articles![index].image!,
                                                ),
                                                title: Text(
                                                  state.articles![index].name!,
                                                  style: AppTheme.themeData
                                                      .textTheme.bodyMedium!
                                                      .copyWith(
                                                          color: AppColors
                                                              .contrast,
                                                          fontSize: 12),
                                                ),
                                                subtitle: Text(
                                                  state.articles![index].path!,
                                                  style: AppTheme.themeData
                                                      .textTheme.bodyMedium!
                                                      .copyWith(
                                                          color: AppColors
                                                              .contrast,
                                                          fontSize: 14),
                                                ),
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                  ExpansionTile(
                                    tilePadding: EdgeInsets.zero,
                                    title: Text(
                                      AppText.exercise,
                                      style: AppTheme
                                          .themeData.textTheme.displayMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w700),
                                    ),
                                    children: [
                                      ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: state.articles!.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<HealthCubit>()
                                                    .launch(state
                                                        .articles![index]
                                                        .path!);
                                              },
                                              child: ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                leading: SmallWorkoutPicture(
                                                  image: state
                                                      .articles![index].image!,
                                                ),
                                                title: Text(
                                                  state.articles![index].name!,
                                                  style: AppTheme.themeData
                                                      .textTheme.bodyMedium!
                                                      .copyWith(
                                                          color: AppColors
                                                              .contrast,
                                                          fontSize: 12),
                                                ),
                                                subtitle: Text(
                                                  state.articles![index].path!,
                                                  style: AppTheme.themeData
                                                      .textTheme.bodyMedium!
                                                      .copyWith(
                                                          color: AppColors
                                                              .contrast,
                                                          fontSize: 14),
                                                ),
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                  ExpansionTile(
                                    tilePadding: EdgeInsets.zero,
                                    title: Text(
                                      AppText.sleep,
                                      style: AppTheme
                                          .themeData.textTheme.displayMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w700),
                                    ),
                                    children: [
                                      ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: state.articles!.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<HealthCubit>()
                                                    .launch(state
                                                        .articles![index]
                                                        .path!);
                                              },
                                              child: ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                leading: SmallWorkoutPicture(
                                                  image: state
                                                      .articles![index].image!,
                                                ),
                                                title: Text(
                                                  state.articles![index].name!,
                                                  style: AppTheme.themeData
                                                      .textTheme.bodyMedium!
                                                      .copyWith(
                                                          color: AppColors
                                                              .contrast,
                                                          fontSize: 12),
                                                ),
                                                subtitle: Text(
                                                  state.articles![index].path!,
                                                  style: AppTheme.themeData
                                                      .textTheme.bodyMedium!
                                                      .copyWith(
                                                          color: AppColors
                                                              .contrast,
                                                          fontSize: 14),
                                                ),
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 17),
                                    child: ExpansionTile(
                                      tilePadding: EdgeInsets.zero,
                                      title: Text(
                                        AppText.remedies,
                                        style: AppTheme
                                            .themeData.textTheme.displayMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w700),
                                      ),
                                      children: [
                                        ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: state.articles!.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<HealthCubit>()
                                                      .launch(state
                                                          .articles![index]
                                                          .path!);
                                                },
                                                child: ListTile(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  leading: SmallWorkoutPicture(
                                                    image: state
                                                        .articles![index]
                                                        .image!,
                                                  ),
                                                  title: Text(
                                                    state
                                                        .articles![index].name!,
                                                    style: AppTheme.themeData
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                            color: AppColors
                                                                .contrast,
                                                            fontSize: 12),
                                                  ),
                                                  subtitle: Text(
                                                    state
                                                        .articles![index].path!,
                                                    style: AppTheme.themeData
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                            color: AppColors
                                                                .contrast,
                                                            fontSize: 14),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //TODO: delete this old comment code

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 20),
                  //   child: Text(
                  //     AppText.neww,
                  //     style: AppTheme.themeData.textTheme.displayMedium!
                  //         .copyWith(fontWeight: FontWeight.w700),
                  //   ),
                  // ),
                  // ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     itemCount: state.files!.length,
                  //     itemBuilder: (context, index) {
                  //       return Padding(
                  //         padding: const EdgeInsets.only(bottom: 23),
                  //         child: GestureDetector(
                  //           onTap: () {
                  //             Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                     builder: (_) => VideoPlayerScreen(
                  //                         video: state.files![index].path!)));
                  //           },
                  //           child: Row(
                  //             children: [
                  //               SmallWorkoutPicture(
                  //                   image: state.files![index].thumbnail!),
                  //               const SizedBox(
                  //                 width: 15,
                  //               ),
                  //               Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text(
                  //                     state.files![index].name!,
                  //                     style: AppTheme
                  //                         .themeData.textTheme.bodyMedium!
                  //                         .copyWith(
                  //                             color: AppColors.contrast,
                  //                             fontSize: 14),
                  //                   ),
                  //                   Text(
                  //                     state.files![index].duration!,
                  //                     style: AppTheme
                  //                         .themeData.textTheme.bodyMedium!
                  //                         .copyWith(
                  //                             color: AppColors.contrast,
                  //                             fontSize: 14),
                  //                   ),
                  //                 ],
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     }),
                  //-------------------------------------
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 20),
                  //   child: ExpansionTile(
                  //     tilePadding: EdgeInsets.zero,
                  //     title: Text(
                  //       AppText.videos,
                  //       style: AppTheme.themeData.textTheme.displayMedium!
                  //           .copyWith(fontWeight: FontWeight.w700),
                  //     ),
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(vertical: 20),
                  //         child: ListView.builder(
                  //             shrinkWrap: true,
                  //             physics: const NeverScrollableScrollPhysics(),
                  //             itemCount: state.files!.length,
                  //             itemBuilder: (context, index) {
                  //               return Padding(
                  //                 padding: const EdgeInsets.only(bottom: 23),
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     Navigator.push(
                  //                         context,
                  //                         MaterialPageRoute(
                  //                             builder: (_) => VideoPlayerScreen(
                  //                                 video: state
                  //                                     .files![index].path!)));
                  //                   },
                  //                   child: Row(
                  //                     children: [
                  //                       SmallWorkoutPicture(
                  //                           image:
                  //                               state.files![index].thumbnail!),
                  //                       const SizedBox(
                  //                         width: 15,
                  //                       ),
                  //                       Column(
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.start,
                  //                         children: [
                  //                           Text(
                  //                             state.files![index].name!,
                  //                             style: AppTheme.themeData
                  //                                 .textTheme.bodyMedium!
                  //                                 .copyWith(
                  //                                     color: AppColors.contrast,
                  //                                     fontSize: 14),
                  //                           ),
                  //                           Text(
                  //                             state.files![index].duration!,
                  //                             style: AppTheme.themeData
                  //                                 .textTheme.bodyMedium!
                  //                                 .copyWith(
                  //                                     color: AppColors.contrast,
                  //                                     fontSize: 14),
                  //                           ),
                  //                         ],
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ),
                  //               );
                  //             }),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 8, bottom: 17),
                  //   child: ExpansionTile(
                  //     tilePadding: EdgeInsets.zero,
                  //     title: Text(
                  //       AppText.articles,
                  //       style: AppTheme.themeData.textTheme.displayMedium!
                  //           .copyWith(fontWeight: FontWeight.w700),
                  //     ),
                  //     children: [
                  //       ListView.builder(
                  //           physics: const NeverScrollableScrollPhysics(),
                  //           shrinkWrap: true,
                  //           itemCount: state.articles!.length,
                  //           itemBuilder: (context, index) {
                  //             return GestureDetector(
                  //               onTap: () {
                  //                 context
                  //                     .read<HealthCubit>()
                  //                     .launch(state.articles![index].path!);
                  //               },
                  //               child: ListTile(
                  //                 contentPadding: EdgeInsets.zero,
                  //                 leading: SmallWorkoutPicture(
                  //                   image: state.articles![index].image!,
                  //                 ),
                  //                 title: Text(
                  //                   state.articles![index].name!,
                  //                   style: AppTheme
                  //                       .themeData.textTheme.bodyMedium!
                  //                       .copyWith(
                  //                           color: AppColors.contrast,
                  //                           fontSize: 12),
                  //                 ),
                  //                 subtitle: Text(
                  //                   state.articles![index].path!,
                  //                   style: AppTheme
                  //                       .themeData.textTheme.bodyMedium!
                  //                       .copyWith(
                  //                           color: AppColors.contrast,
                  //                           fontSize: 14),
                  //                 ),
                  //               ),
                  //             );
                  //           }),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 8, bottom: 17),
                  //   child: ExpansionTile(
                  //     tilePadding: EdgeInsets.zero,
                  //     title: Text(
                  //       AppText.vitamins,
                  //       style: AppTheme.themeData.textTheme.displayMedium!
                  //           .copyWith(fontWeight: FontWeight.w700),
                  //     ),
                  //     children: [
                  //       ListView.builder(
                  //           physics: const NeverScrollableScrollPhysics(),
                  //           shrinkWrap: true,
                  //           itemCount: state.articles!.length,
                  //           itemBuilder: (context, index) {
                  //             return GestureDetector(
                  //               onTap: () {
                  //                 context
                  //                     .read<HealthCubit>()
                  //                     .launch(state.articles![index].path!);
                  //               },
                  //               child: ListTile(
                  //                 contentPadding: EdgeInsets.zero,
                  //                 leading: SmallWorkoutPicture(
                  //                   image: state.articles![index].image!,
                  //                 ),
                  //                 title: Text(
                  //                   state.articles![index].name!,
                  //                   style: AppTheme
                  //                       .themeData.textTheme.bodyMedium!
                  //                       .copyWith(
                  //                           color: AppColors.contrast,
                  //                           fontSize: 12),
                  //                 ),
                  //                 subtitle: Text(
                  //                   state.articles![index].path!,
                  //                   style: AppTheme
                  //                       .themeData.textTheme.bodyMedium!
                  //                       .copyWith(
                  //                           color: AppColors.contrast,
                  //                           fontSize: 14),
                  //                 ),
                  //               ),
                  //             );
                  //           }),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 8, bottom: 17),
                  //   child: ExpansionTile(
                  //     tilePadding: EdgeInsets.zero,
                  //     title: Text(
                  //       AppText.fitness,
                  //       style: AppTheme.themeData.textTheme.displayMedium!
                  //           .copyWith(fontWeight: FontWeight.w700),
                  //     ),
                  //     children: [
                  //       ListView.builder(
                  //           physics: const NeverScrollableScrollPhysics(),
                  //           shrinkWrap: true,
                  //           itemCount: state.articles!.length,
                  //           itemBuilder: (context, index) {
                  //             return GestureDetector(
                  //               onTap: () {
                  //                 context
                  //                     .read<HealthCubit>()
                  //                     .launch(state.articles![index].path!);
                  //               },
                  //               child: ListTile(
                  //                 contentPadding: EdgeInsets.zero,
                  //                 leading: SmallWorkoutPicture(
                  //                   image: state.articles![index].image!,
                  //                 ),
                  //                 title: Text(
                  //                   state.articles![index].name!,
                  //                   style: AppTheme
                  //                       .themeData.textTheme.bodyMedium!
                  //                       .copyWith(
                  //                           color: AppColors.contrast,
                  //                           fontSize: 12),
                  //                 ),
                  //                 subtitle: Text(
                  //                   state.articles![index].path!,
                  //                   style: AppTheme
                  //                       .themeData.textTheme.bodyMedium!
                  //                       .copyWith(
                  //                           color: AppColors.contrast,
                  //                           fontSize: 14),
                  //                 ),
                  //               ),
                  //             );
                  //           }),
                  //     ],
                  //   ),
                  // ),
                  //-------------------------------------
                  //TODO: delete this old comment code
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 8, bottom: 17),
                  //   child: Text(
                  //     AppText.articles,
                  //     style: AppTheme.themeData.textTheme.displayMedium!
                  //         .copyWith(fontWeight: FontWeight.w700),
                  //   ),
                  // ),
                  // ListView.builder(
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     shrinkWrap: true,
                  //     itemCount: state.articles!.length,
                  //     itemBuilder: (context, index) {
                  //       return GestureDetector(
                  //         onTap: () {
                  //           context
                  //               .read<HealthCubit>()
                  //               .launch(state.articles![index].path!);
                  //         },
                  //         child: ListTile(
                  //           contentPadding: EdgeInsets.zero,
                  //           leading: SmallWorkoutPicture(
                  //             image: state.articles![index].image!,
                  //           ),
                  //           title: Text(
                  //             state.articles![index].name!,
                  //             style: AppTheme.themeData.textTheme.bodyMedium!
                  //                 .copyWith(
                  //                     color: AppColors.contrast, fontSize: 12),
                  //           ),
                  //           subtitle: Text(
                  //             state.articles![index].path!,
                  //             style: AppTheme.themeData.textTheme.bodyMedium!
                  //                 .copyWith(
                  //                     color: AppColors.contrast, fontSize: 14),
                  //           ),
                  //         ),
                  //       );
                  //     }),
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
// ListView.builder(
// physics: const NeverScrollableScrollPhysics(),
// shrinkWrap: true,
// itemCount: state.articles!.length,
// itemBuilder: (context, index) {
// return GestureDetector(
// onTap: () {
// context.read<HealthCubit>().launch(
// state.articles![index].path!);
// },
// child: ListTile(
// contentPadding: EdgeInsets.zero,
// leading: SmallWorkoutPicture(
// image: state.articles![index].image!,
// ),
// title: Text(
// state.articles![index].name!,
// style: AppTheme
//     .themeData.textTheme.bodyMedium!
//     .copyWith(
// color: AppColors.contrast,
// fontSize: 12),
// ),
// subtitle: Text(
// state.articles![index].path!,
// style: AppTheme
//     .themeData.textTheme.bodyMedium!
//     .copyWith(
// color: AppColors.contrast,
// fontSize: 14),
// ),
// ),
// );
// }),
