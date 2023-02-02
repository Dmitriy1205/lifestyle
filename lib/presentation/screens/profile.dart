import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lifestyle/common/constants/colors.dart';
import 'package:lifestyle/common/constants/icons.dart';
import 'package:lifestyle/common/themes/theme.dart';
import 'package:lifestyle/presentation/bloc/profile/profile_cubit.dart';
import 'package:lifestyle/presentation/screens/sign_in.dart';
import 'package:lifestyle/presentation/widgets/profile_menu_component.dart';

import '../../common/constants/constants.dart';
import '../../common/services/service_locator.dart';
import 'info.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileCubit>(),
      child: Scaffold(
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state.status!.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainAccent,
                ),
              );
            }
            return Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => Info(userEmail: state.email!,)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.mainAccent,
                        border:
                            Border(bottom: BorderSide(color: AppColors.active)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 60, left: 35, bottom: 20),
                        child: Row(
                          children: [
                            Icon(
                              AppIcons.user,
                              color: AppColors.white,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.email!,
                                  style:
                                      AppTheme.themeData.textTheme.labelLarge,
                                ),
                                Text(
                                  '${AppText.memberSince} ${Jiffy(state.date).yMMMMd}',
                                  style:
                                      AppTheme.themeData.textTheme.labelSmall,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Column(
                      children: [
                        ProfileMenuComponent(
                            prefixIcon: Icon(
                              AppIcons.edit,
                              color: AppColors.active,
                              size: 20,
                            ),
                            text: AppText.editProfile),
                        Divider(
                          thickness: 2,
                          color: AppColors.active,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ProfileMenuComponent(
                            prefixIcon: Icon(
                              AppIcons.users,
                              color: AppColors.active,
                              size: 18,
                            ),
                            text: AppText.support),
                        Divider(
                          thickness: 2,
                          color: AppColors.active,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ProfileMenuComponent(
                            tap: () {
                              BlocProvider.of<ProfileCubit>(context)
                                  .logout()
                                  .then(
                                    (value) => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => SignIn(),
                                      ),
                                    ),
                                  );
                            },
                            prefixIcon: Icon(
                              AppIcons.logout,
                              color: AppColors.active,
                              size: 20,
                            ),
                            text: AppText.logout),
                        Divider(
                          thickness: 2,
                          color: AppColors.active,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
