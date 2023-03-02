import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/common/constants/colors.dart';
import 'package:lifestyle/common/constants/constants.dart';
import 'package:lifestyle/common/themes/theme.dart';
import 'package:lifestyle/presentation/bloc/create_profile/gender/gender_cubit.dart';
import 'package:lifestyle/presentation/widgets/create_profile_body.dart';
import 'package:lifestyle/presentation/widgets/loading_indicator.dart';

import '../../../common/services/service_locator.dart';

class GenderScreen extends StatelessWidget {
  final Future<void> Function()? controlToNext;
  final bool fromProfile;
  final String? current;

  const GenderScreen({
    Key? key,
    this.controlToNext,
    this.fromProfile = false,
    this.current,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GenderCubit>(),
      child: Scaffold(
        body: BlocBuilder<GenderCubit, GenderState>(
          builder: (context, state) {
            if (state.status!.isLoading) {
              return const LoadingIndicator();
            }
            return CreateProfileBody(
              fromProfile: fromProfile,
              isFirst: AppVariables.first,
              title: AppText.whatsGender,
              content: Padding(
                padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<GenderCubit>().setGender(Gender.woman);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: state.gender == Gender.woman
                                ? AppColors.mainAccent
                                : current == AppText.woman
                                    ? AppColors.mainAccent
                                    : AppColors.grey,
                            borderRadius: BorderRadius.circular(15)),
                        height: 96,
                        width: 96,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.venus,
                              size: 40,
                            ),
                            Text(
                              AppText.woman,
                              style: AppTheme.themeData.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<GenderCubit>().setGender(
                              Gender.man,
                            );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: state.gender == Gender.man
                              ? AppColors.mainAccent
                              : current == AppText.man
                                  ? AppColors.mainAccent
                                  : AppColors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 96,
                        width: 96,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.mars,
                              size: 40,
                            ),
                            Text(
                              AppText.man,
                              style: AppTheme.themeData.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              buttonTitle: AppText.next,
              onTapNext: state.gender == null
                  ? null
                  : () {
                      return context
                          .read<GenderCubit>()
                          .accept(state.genderName!)
                          .then((value) => controlToNext!());
                    },
              onEdit: () {
                return context
                    .read<GenderCubit>()
                    .accept(state.genderName!)
                    .then((value) => Navigator.pop(context));
              },
            );
          },
        ),
      ),
    );
  }
}
