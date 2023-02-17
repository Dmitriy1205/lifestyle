import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/constants/colors.dart';
import 'loading_indicator.dart';

class BigWorkoutPicture extends StatelessWidget {
  const BigWorkoutPicture({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: AppColors.grey,
        height: 191,
        width: MediaQuery.of(context).size.width,
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: image,
          placeholder: (context, url) => const LoadingIndicator(),
          errorWidget: (context, url, error) => const Center(
            child: FaIcon(
              FontAwesomeIcons.solidImage,
              size: 36,
              color: AppColors.active,
            ),
          ),
        ),
      ),
    );
  }
}
