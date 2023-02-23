import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lifestyle/common/constants/colors.dart';
import 'package:lifestyle/common/constants/icons.dart';
import 'package:lifestyle/common/themes/theme.dart';
import 'package:lifestyle/presentation/bloc/profile/profile_cubit.dart';
import 'package:lifestyle/presentation/screens/create_profile/tags.dart';
import 'package:lifestyle/presentation/screens/create_profile/weight.dart';
import 'package:lifestyle/presentation/screens/profile/support.dart';
import 'package:lifestyle/presentation/screens/profile/your_workouts.dart';
import 'package:lifestyle/presentation/screens/sign_in.dart';
import 'package:lifestyle/presentation/widgets/profile_menu_component.dart';

import '../../../common/constants/constants.dart';
import '../../../common/services/service_locator.dart';
import '../create_profile/age.dart';
import '../create_profile/gender.dart';
import '../create_profile/height.dart';
import 'edit_profile.dart';
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
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainAccent,
                ),
              );
            }
            return Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Info(
                            userEmail: state.email!,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 128,
                            width: 128,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundColor: AppColors.white,
                              child: Image.asset('assets/images/user.png'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          state.email!,
                          style: AppTheme.themeData.textTheme.titleSmall,
                        ),
                        Text(
                          '${AppText.memberSince} ${Jiffy(state.date).yMMMMd}',
                          style: AppTheme.themeData.textTheme.labelSmall,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileMenuComponent(
                          prefixIcon: const Icon(
                            AppIcons.edit,
                            color: AppColors.active,
                            size: 20,
                          ),
                          text: AppText.editProfile,
                          tap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const EditProfile(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ProfileMenuComponent(
                          prefixIcon: const Icon(
                            AppIcons.gym,
                            color: AppColors.active,
                            size: 20,
                          ),
                          text: AppText.yourWorkout,
                          tap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const YourWorkouts(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ProfileMenuComponent(
                          prefixIcon: const Icon(
                            AppIcons.users,
                            color: AppColors.active,
                            size: 20,
                          ),
                          text: AppText.support,
                          tap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const Support(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
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
                                        builder: (_) => const SignIn(),
                                      ),
                                    ),
                                  );
                            },
                            prefixIcon: const Icon(
                              AppIcons.logout,
                              color: AppColors.active,
                              size: 20,
                            ),
                            text: AppText.logout),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppText.editStats,
                          style: AppTheme.themeData.textTheme.titleSmall,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ProfileMenuComponent(
                          prefixIcon: Text(
                            AppText.gender,
                            style: AppTheme.themeData.textTheme.displaySmall,
                          ),
                          text: '',
                          tap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => GenderScreen(
                                  fromProfile: true,
                                  current: state.profile!.gender,
                                ),
                              ),
                            ).then(
                                (value) => context.read<ProfileCubit>().init());
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ProfileMenuComponent(
                          prefixIcon: Text(
                            AppText.age,
                            style: AppTheme.themeData.textTheme.displaySmall,
                          ),
                          text: '',
                          tap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AgeScreen(
                                  fromProfile: true,
                                  age: state.profile!.age,
                                ),
                              ),
                            ).then(
                                (value) => context.read<ProfileCubit>().init());
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ProfileMenuComponent(
                          prefixIcon: Text(
                            AppText.height,
                            style: AppTheme.themeData.textTheme.displaySmall,
                          ),
                          text: '',
                          tap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => HeightScreen(
                                  fromProfile: true,
                                  height: state.profile!.height,
                                ),
                              ),
                            ).then(
                                (value) => context.read<ProfileCubit>().init());
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ProfileMenuComponent(
                          prefixIcon: Text(
                            AppText.weight,
                            style: AppTheme.themeData.textTheme.displaySmall,
                          ),
                          text: '',
                          tap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => WeightScreen(
                                  weight: state.profile!.weight,
                                  fromProfile: true,
                                ),
                              ),
                            ).then(
                                (value) => context.read<ProfileCubit>().init());
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ProfileMenuComponent(
                          prefixIcon: Text(
                            AppText.favoriteTopic,
                            style: AppTheme.themeData.textTheme.displaySmall,
                          ),
                          text: '',
                          tap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TagsScreen(
                                  fromProfile: true,
                                  topic: state.profile!.topics,
                                ),
                              ),
                            ).then(
                                (value) => context.read<ProfileCubit>().init());
                          },
                        ),
                        const SizedBox(
                          height: 50,
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
