import 'package:flutter/material.dart';

import '../../../common/constants/colors.dart';
import '../../../common/constants/constants.dart';
import '../../../common/constants/icons.dart';
import '../../../common/themes/theme.dart';

class DescriptionScreen extends StatelessWidget {
  final String header;
  final String content;

  const DescriptionScreen({
    Key? key,
    required this.header,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        centerTitle: true,
        title: Text(
          header.toUpperCase(),
          style: AppTheme.themeData.textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  AppText.warningText,
                  style: AppTheme.themeData.textTheme.bodyMedium!.copyWith(
                      color: AppColors.red, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                content.replaceAll('\\n', '\n '),
                style: AppTheme.themeData.textTheme.displayMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
