import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/presentation/widgets/loading_indicator.dart';

import '../../common/constants/colors.dart';

class SmallWorkoutPicture extends StatelessWidget {
  final String image;

  const SmallWorkoutPicture({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: AppColors.grey,
        height: 65,
        width: 65,
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: image,
          placeholder: (context, url) => const LoadingIndicator(),
          errorWidget: (context, url, error) => const Center(
            child: FaIcon(
              FontAwesomeIcons.solidImage,
              size: 20,
              color: AppColors.active,
            ),
          ),
        ),
      ),
    );
  }
}
