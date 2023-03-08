import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/presentation/bloc/profile/edit_profile/edit_profile_cubit.dart';
import 'package:lifestyle/presentation/widgets/image_picker.dart';

import '../../../common/constants/colors.dart';
import '../../../common/constants/constants.dart';
import '../../../common/constants/icons.dart';
import '../../../common/themes/theme.dart';
import '../../widgets/connection_message.dart';
import '../../widgets/loading_indicator.dart';

class EditProfile extends StatefulWidget {
  final String? userEmail;
  final String? image;

  const EditProfile({
    Key? key,
    this.userEmail,
    this.image,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    context.read<EditProfileCubit>().init(widget.userEmail!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        if (state.status!.isLoading) {
          return const Material(
            child: LoadingIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                AppIcons.back,
                color: AppColors.contrast,
                size: 20,
              ),
            ),
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    onPressed: () {
                      state.source == Source.cache
                          ? ConnectionMessage.buildErrorSnackbar(context)
                          : context
                              .read<EditProfileCubit>()
                              .updateFields(
                                state.image,
                                widget.image!,
                                state.nameController!.text,
                              )
                              .then((value) => Navigator.pop(context));
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.check,
                      color: AppColors.green,
                    ),
                  ),
                ),
              )
            ],
            centerTitle: true,
            title: Text(
              AppText.editProfile.toUpperCase(),
              style: AppTheme.themeData.textTheme.displayLarge,
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 150,
                      width: 175,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          PicturePicker(
                            userImage: (file) {
                              context.read<EditProfileCubit>().getImage(file);
                            },
                            avatar: const SizedBox(),
                            imageFromProfile: widget.image,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    AppText.username,
                    style: AppTheme.themeData.textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: state.nameController,
                    style: AppTheme.themeData.textTheme.displayMedium,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      hintText: AppText.email,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
