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

  TagsScreen({
    Key? key,
    this.controlToPrev,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TagsCubit>(),
      child: Scaffold(
        body: BlocBuilder<TagsCubit, TagsState>(
          builder: (context, state) {
            return CreateProfileBody(
              title: AppText.whatTopic,
              buttonTitle: AppText.finish,
              content: Wrap(
                children: List<Widget>.generate(
                  state.tags!.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: GestureDetector(
                      onTap: () {
                        state.tags!.values.elementAt(index)
                            ? context.read<TagsCubit>().setValue(
                                index, !state.tags!.values.elementAt(index))
                            : context.read<TagsCubit>().setValue(
                                index, !state.tags!.values.elementAt(index));

                        print(state.tags);
                      },
                      child: Chip(
                        backgroundColor: state.tags!.values.elementAt(index)
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
                ).toList(),
              ),
              onTapPrev: controlToPrev,
              onTapNext: () {
                return context.read<TagsCubit>().accept(state.tags!).then(
                      (value) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MainScreen(),
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
