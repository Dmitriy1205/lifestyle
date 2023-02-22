import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifestyle/common/constants/colors.dart';
import 'package:lifestyle/common/themes/theme.dart';
import 'package:lifestyle/presentation/screens/main_screen.dart';
import 'package:lifestyle/presentation/widgets/create_profile_body.dart';

import '../../../common/constants/constants.dart';
import '../../../common/services/service_locator.dart';
import '../../bloc/create_profile/tags/tags_cubit.dart';

class TagsScreen extends StatelessWidget {
  final Function()? controlToPrev;
  final Function()? edit;
  final bool fromProfile;
  final Map<String, dynamic>? topic;

  const TagsScreen({
    Key? key,
    this.controlToPrev,
    this.edit,
    this.fromProfile = false,
    this.topic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TagsCubit>(),
      child: Scaffold(
        body: BlocBuilder<TagsCubit, TagsState>(
          builder: (context, state) {
            return CreateProfileBody(
              fromProfile: fromProfile,
              onEdit: () {
                return context.read<TagsCubit>().accept(state.tags!).then(
                      (value) => Navigator.pop(context),
                    );
              },
              title: AppText.whatTopic,
              buttonTitle: AppText.finish,
              content: Wrap(
                children: topic == null
                    ? List<Widget>.generate(
                        state.tags!.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: GestureDetector(
                            onTap: () {
                              state.tags!.values.elementAt(index)
                                  ? context.read<TagsCubit>().setValue(
                                      index,
                                      !state.tags!.values.elementAt(index),
                                      AppText.topics)
                                  : context.read<TagsCubit>().setValue(
                                      index,
                                      !state.tags!.values.elementAt(index),
                                      AppText.topics);
                            },
                            child: Chip(
                              backgroundColor:
                                  state.tags!.values.elementAt(index)
                                      ? AppColors.contrast
                                      : AppColors.disabled,
                              label: Text(
                                state.tags!.keys.elementAt(index),
                                style: AppTheme.themeData.textTheme.bodyMedium!
                                    .copyWith(fontSize: 10),
                              ),
                            ),
                          ),
                        ),
                      ).toList()
                    : List<Widget>.generate(
                        topic!.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: GestureDetector(
                            onTap: () {
                              topic!.values.elementAt(index)
                                  ? context.read<TagsCubit>().setValue(index,
                                      !topic!.values.elementAt(index), topic!)
                                  : context.read<TagsCubit>().setValue(index,
                                      !topic!.values.elementAt(index), topic!);
                            },
                            child: Chip(
                              backgroundColor: topic!.values.elementAt(index)
                                  ? AppColors.contrast
                                  : AppColors.disabled,
                              label: Text(
                                topic!.keys.elementAt(index),
                                style: AppTheme.themeData.textTheme.bodyMedium!
                                    .copyWith(fontSize: 10),
                              ),
                            ),
                          ),
                        ),
                      ).toList(),
              ),
              onTapPrev: controlToPrev,
              onTapNext: () {
                return context.read<TagsCubit>().accept(state.tags!).then(
                      (value) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MainScreen(),
                        ),
                      ),
                    );
              },
            );
          },
        ),
      ),
    );
  }
}
