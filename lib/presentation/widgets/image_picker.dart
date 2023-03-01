import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifestyle/presentation/widgets/loading_indicator.dart';

import '../../common/constants/colors.dart';
import '../../common/services/service_locator.dart';
import '../../common/themes/theme.dart';
import '../bloc/image_picker/image_picker_cubit.dart';

class PicturePicker extends StatelessWidget {
  final Function(File) userImage;
  final Widget? avatar;
  final String? imageFromProfile;

  const PicturePicker({
    Key? key,
    required this.userImage,
    this.avatar,
    this.imageFromProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ImagePickerCubit>(),
      child: _PicturePicker(
        userImage: userImage,
        avatar: avatar,
        imageFromProfile: imageFromProfile,
      ),
    );
  }
}

class _PicturePicker extends StatelessWidget {
  final Function(File) userImage;
  final Widget? avatar;
  final String? imageFromProfile;

  const _PicturePicker({
    Key? key,
    required this.userImage,
    required this.avatar,
    this.imageFromProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerCubit, ImagePickerState>(
      builder: (context, state) {
        if (state.status!.isLoading) {
          return const Material(
            child: LoadingIndicator(),
          );
        }
        return Stack(
          children: [
            avatar == null
                ? Container(
                    height: 191,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: state.image == null
                          ? const FaIcon(
                              FontAwesomeIcons.solidImage,
                              size: 36,
                              color: AppColors.active,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                state.image!,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  )
                : Center(
                    child: state.image == null
                        ? imageFromProfile == null
                            ? CircleAvatar(
                                radius: 70,
                                backgroundColor: AppColors.white,
                                child: Image.asset('assets/images/user.png'))
                            : SizedBox(
                                height: 138,
                                width: 138,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(70),
                                    child: Image.network(
                                      imageFromProfile!,
                                      fit: BoxFit.cover,
                                    )),
                              )
                        : SizedBox(
                            height: 138,
                            width: 138,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(70),
                              child: Image.file(
                                state.image!,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
            Positioned(
              right: avatar == null ? 10 : 0,
              bottom: avatar == null ? 8 : 0,
              child: GestureDetector(
                onTap: () {
                  showPicker(context, func: (f) {
                    userImage(f!);
                  });
                },
                child: const CircleAvatar(
                  backgroundColor: AppColors.contrast,
                  radius: 26,
                  child: Icon(
                    Icons.photo_camera,
                    color: AppColors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showPicker(BuildContext context,
      {required void Function(File? f) func}) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 25),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                            title: Center(
                              child: Text(
                                'Photo',
                                style: AppTheme.themeData.textTheme.titleSmall,
                              ),
                            ),
                            onTap: () {
                              imageFromCamera(context, getPhoto: (f) {
                                func(f);
                              });

                              Navigator.of(context).pop();
                            }),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        ListTile(
                            title: Center(
                              child: Text(
                                'Image',
                                style: AppTheme.themeData.textTheme.titleSmall,
                              ),
                            ),
                            onTap: () {
                              imageFromGallery(context, getImage: (f) {
                                func(f);
                              });

                              Navigator.of(context).pop();
                            }),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 22, right: 22, bottom: 22),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 340,
                      height: 55,
                      alignment: Alignment.center,
                      child: Text(
                        'Cancel',
                        style: AppTheme.themeData.textTheme.titleLarge,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future imageFromGallery(context, {required Function(File?) getImage}) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 480,
      maxHeight: 640,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      BlocProvider.of<ImagePickerCubit>(context)
          .getImage(File(pickedFile.path));
      getImage(File(pickedFile.path));
    } else {
      // print('No image selected.');
    }
  }

  Future imageFromCamera(context, {required Function(File?) getPhoto}) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 480,
      maxHeight: 640,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      BlocProvider.of<ImagePickerCubit>(context)
          .getImage(File(pickedFile.path));
      getPhoto(File(pickedFile.path));
    } else {
      // print('No image selected.');
    }
  }
}
