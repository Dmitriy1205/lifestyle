import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifestyle/presentation/widgets/loading_indicator.dart';
import 'package:lifestyle/presentation/widgets/small_workout_picture.dart';

import '../../common/constants/colors.dart';
import '../../common/constants/constants.dart';
import '../../common/services/service_locator.dart';
import '../../common/themes/theme.dart';
import '../bloc/home/search_screen/search_cubit.dart';
import '../screens/home_screen/description_screen.dart';
import '../screens/video_player_screen.dart';
import 'connection_message.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchCubit>(),
      child: Scaffold(
        body: BlocConsumer<SearchCubit, SearchState>(
          listener: (context, state) {
            if (state.isConnected! == false) {
              ConnectionMessage.buildDisconnectedSnackbar(context);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: state.controller,
                    style: AppTheme.themeData.textTheme.displayMedium,
                    decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        hintText: AppText.search),
                    onChanged: (String name) {
                      context
                          .read<SearchCubit>()
                          .searchFields(name, state.isConnected!);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  state.status!.isLoading
                      ? const LoadingIndicator()
                      : state.status!.isError
                          ? Center(
                              child: Text(
                                state.status!.errorMessage!,
                                style:
                                    AppTheme.themeData.textTheme.displayMedium,
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: state.files!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return state.files![index].type == 'null'
                                      ? const SizedBox()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 15),
                                          child: GestureDetector(
                                            onTap: () {
                                              state.files![index].type ==
                                                      'vitamins'
                                                  ? Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            DescriptionScreen(
                                                          header: state
                                                              .files![index]
                                                              .name!,
                                                          content: state
                                                              .files![index]
                                                              .content!,
                                                        ),
                                                      ),
                                                    )
                                                  : !state.isConnected!
                                                      ? ConnectionMessage
                                                          .buildDisconnectedSnackbar(
                                                              context)
                                                      : Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (_) =>
                                                                VideoPlayerScreen(
                                                                    video: state
                                                                        .files![
                                                                            index]
                                                                        .path!),
                                                          ),
                                                        );
                                            },
                                            child: Row(
                                              children: [
                                                SmallWorkoutPicture(
                                                    image: state
                                                        .files![index].image!),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const SizedBox(),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .mainAccent,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 4,
                                                                  horizontal:
                                                                      8),
                                                              child: Text(
                                                                state
                                                                    .files![
                                                                        index]
                                                                    .type!,
                                                                style: AppTheme
                                                                    .themeData
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .contrast,
                                                                        fontSize:
                                                                            10),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        state.files![index]
                                                            .name!,
                                                        style: AppTheme
                                                            .themeData
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .contrast,
                                                                fontSize: 14),
                                                      ),
                                                      state.files![index]
                                                                  .duration ==
                                                              'null'
                                                          ? const SizedBox()
                                                          : Text(
                                                              state
                                                                  .files![index]
                                                                  .duration!,
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
                                                      const SizedBox(
                                                        height: 25,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                },
                              ),
                            ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
