import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 80,),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 128,
                                width: 128,
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundColor: AppColors.white,
                                  child: Image.asset('assets/images/user.png'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              state.email!,
                              style:
                                  AppTheme.themeData.textTheme.titleSmall,
                            ),
                            Text(
                              '${AppText.memberSince} ${Jiffy(state.date).yMMMMd}',
                              style:
                                  AppTheme.themeData.textTheme.labelSmall,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileMenuComponent(
                            prefixIcon: Icon(
                              AppIcons.edit,
                              color: AppColors.active,
                              size: 20,
                            ),
                            text: AppText.editProfile),

                        SizedBox(
                          height: 20,
                        ),
                        ProfileMenuComponent(
                            prefixIcon: FaIcon(
                              FontAwesomeIcons.dumbbell,
                              color: AppColors.active,
                              size: 20,
                            ),
                            text: AppText.yourWorkout),
                        SizedBox(
                          height: 20,
                        ),
                        ProfileMenuComponent(
                            prefixIcon: Icon(
                              AppIcons.users,
                              color: AppColors.active,
                              size: 20,
                            ),
                            text: AppText.support),

                        SizedBox(
                          height: 20,
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
                        SizedBox(
                          height: 20,
                        ),
                        Text(AppText.editStats,style: AppTheme.themeData.textTheme.titleSmall,),
                        SizedBox(
                          height: 20,
                        ),
                        ProfileMenuComponent(
                            prefixIcon: Text(AppText.gender,style: AppTheme.themeData.textTheme.displaySmall,), text: '',),
                        SizedBox(
                          height: 20,
                        ),
                        ProfileMenuComponent(
                            prefixIcon: Text(AppText.age,style: AppTheme.themeData.textTheme.displaySmall,), text: '',),
                        SizedBox(
                          height: 20,
                        ),
                        ProfileMenuComponent(
                            prefixIcon: Text(AppText.height,style: AppTheme.themeData.textTheme.displaySmall,), text: '',),
                        SizedBox(
                          height: 20,
                        ),
                        ProfileMenuComponent(
                            prefixIcon: Text(AppText.weight,style: AppTheme.themeData.textTheme.displaySmall,), text: '',),
                        SizedBox(
                          height: 20,
                        ),
                        ProfileMenuComponent(
                            prefixIcon: Text(AppText.favoriteTopic,style: AppTheme.themeData.textTheme.displaySmall,), text: '',),
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
