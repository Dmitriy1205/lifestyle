import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifestyle/common/utils/validator.dart';

import '../../../common/constants/colors.dart';
import '../../../common/constants/constants.dart';
import '../../../common/constants/icons.dart';
import '../../../common/themes/theme.dart';

class RelaxBuilder extends StatefulWidget {
  final Function(String) add;
  const RelaxBuilder({Key? key, required this.add}) : super(key: key);

  @override
  State<RelaxBuilder> createState() => _RelaxBuilderState();
}

class _RelaxBuilderState extends State<RelaxBuilder> {
  final _formKey = GlobalKey<FormState>();
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
        centerTitle: true,
        title: Text(
          AppText.relaxTime,
          style: AppTheme.themeData.textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: controller,
                style: AppTheme.themeData.textTheme.displayMedium,
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    hintText: AppText.seconds),
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
            const SizedBox(
              height: 22,
            ),
            ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                _formKey.currentState!.save();
                widget.add(controller.text);
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
