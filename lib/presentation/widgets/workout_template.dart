import 'package:flutter/material.dart';
import 'package:lifestyle/common/utils/validator.dart';

import '../../common/constants/colors.dart';
import '../../common/constants/constants.dart';
import '../../common/constants/icons.dart';
import '../../common/themes/theme.dart';

class EditableWorkoutTemplate extends StatefulWidget {
  final String buttonName;
  final Function() toRelax;
  final Function() toTraining;
  final Function() onButtonClick;
  final Widget exerciseList;
  final Widget imagePicker;
  final TextEditingController? initialName;
  final TextEditingController? initialRecommendation;
  final TextEditingController? initialDescription;

  const EditableWorkoutTemplate({
    Key? key,
    required this.buttonName,
    required this.toRelax,
    required this.toTraining,
    required this.onButtonClick,
    required this.exerciseList,
    this.initialName,
    this.initialRecommendation,
    this.initialDescription,
    required this.imagePicker,
  }) : super(key: key);

  @override
  State<EditableWorkoutTemplate> createState() => _EditableWorkoutTemplateState();
}

class _EditableWorkoutTemplateState extends State<EditableWorkoutTemplate> {
  final _formKey = GlobalKey<FormState>();

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
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          shrinkWrap: true,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.imagePicker,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      AppText.trainingName,
                      style: AppTheme.themeData.textTheme.displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  TextFormField(
                    controller: widget.initialName,
                    style: AppTheme.themeData.textTheme.displayMedium,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    validator: context.validateFieldNotEmpty,
                    // onSaved: (value) {
                    //   widget.initialName!.text = value!.trim();
                    // },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      AppText.description,
                      style: AppTheme.themeData.textTheme.displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  TextFormField(
                    controller: widget.initialDescription,
                    style: AppTheme.themeData.textTheme.displayMedium,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    validator: context.validateFieldNotEmpty,
                    // onSaved: (value) {
                    //   widget.initialDescription!.text = value!.trim();
                    // }
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      AppText.mealsRecommendations,
                      style: AppTheme.themeData.textTheme.displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  TextFormField(
                    controller: widget.initialRecommendation,
                    style: AppTheme.themeData.textTheme.displayMedium,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    validator: context.validateFieldNotEmpty,
                    // onSaved: (value) {
                    //   widget.initialRecommendation!.text = value!.trim();
                    // }
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      AppText.exercises,
                      style: AppTheme.themeData.textTheme.labelLarge!
                          .copyWith(fontSize: 16),
                    ),
                  ),
                  widget.exerciseList,
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 24,
                        width: 84,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.contrast,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: widget.toTraining,
                          child: Text(
                            '+ ${AppText.training}',
                            style: AppTheme.themeData.textTheme.displaySmall!
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 27,
                      ),
                      SizedBox(
                        height: 24,
                        width: 84,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.contrast,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: widget.toRelax,
                          child: Text(
                            '+ ${AppText.relax}',
                            style: AppTheme.themeData.textTheme.displaySmall!
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();
                      widget.onButtonClick();
                    },
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 18,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          widget.buttonName,
                          style: AppTheme.themeData.textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
