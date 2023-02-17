import 'package:flutter/cupertino.dart';

import '../../common/constants/colors.dart';
import '../../common/constants/icons.dart';
import '../../common/themes/theme.dart';

class ProfileMenuComponent extends StatelessWidget {
  final Widget prefixIcon;
  final String text;
  final Function()? tap;

  const ProfileMenuComponent({
    Key? key,
    required this.prefixIcon,
    required this.text,
    this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              prefixIcon,
              const SizedBox(
                width: 15,
              ),
              Text(
                text,
                style: AppTheme.themeData.textTheme.displaySmall,
              )
            ],
          ),
          const Icon(
            AppIcons.next,
            color: AppColors.disabled,
            size: 14,
          ),
        ],
      ),
    );
  }
}
