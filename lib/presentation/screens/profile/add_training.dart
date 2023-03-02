import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/common/utils/validator.dart';
import 'package:lifestyle/data/models/exercises.dart';
import 'package:lifestyle/presentation/widgets/small_workout_picture.dart';

import '../../../common/constants/colors.dart';
import '../../../common/constants/constants.dart';
import '../../../common/constants/icons.dart';
import '../../../common/themes/theme.dart';

class AddTrainingScreen extends StatefulWidget {
  final String name;
  final String image;
  final Function(Exercises) addExercise;

  const AddTrainingScreen({
    Key? key,
    required this.name,
    required this.image,
    required this.addExercise,
  }) : super(key: key);

  @override
  State<AddTrainingScreen> createState() => _AddTrainingScreenState();
}

class _AddTrainingScreenState extends State<AddTrainingScreen> {
  final _formKey = GlobalKey<FormState>();
  String selectedValue = AppText.seconds;
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
        title: Text(
          AppText.exercise.toUpperCase(),
          style: AppTheme.themeData.textTheme.displayLarge,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                SmallWorkoutPicture(image: widget.image),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: AppTheme.themeData.textTheme.bodyMedium!
                          .copyWith(color: AppColors.contrast, fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 21,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 66,
                  width: 137,
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: controller,
                      style: AppTheme.themeData.textTheme.displayMedium,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        hintText: AppText.unit,
                      ),
                      validator: context.validateFieldNotEmpty,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp("[0-9]"),
                        ),
                        FilteringTextInputFormatter.deny(
                          RegExp(r'^0+'), //users can't type 0 at 1st position
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  height: 47,
                  width: 137,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.active),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Center(
                      child: DropdownButton(
                        alignment: AlignmentDirectional.center,
                        value: selectedValue,
                        icon: const Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: FaIcon(
                            FontAwesomeIcons.angleDown,
                            size: 14,
                            color: AppColors.contrast,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        underline: const SizedBox(),
                        items: [
                          DropdownMenuItem(
                            value: AppText.seconds,
                            child: Text(
                              AppText.seconds,
                              style: AppTheme.themeData.textTheme.displayMedium,
                            ),
                          ),
                          DropdownMenuItem(
                            value: AppText.minutes,
                            child: Text(
                              AppText.minutes,
                              style: AppTheme.themeData.textTheme.displayMedium,
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                _formKey.currentState!.save();
                widget.addExercise(
                  Exercises(
                    image: widget.image,
                    name: widget.name,
                    duration: controller.text,
                    timeValue: selectedValue,
                  ),
                );

                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 18,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    AppText.add,
                    style: AppTheme.themeData.textTheme.titleLarge,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
