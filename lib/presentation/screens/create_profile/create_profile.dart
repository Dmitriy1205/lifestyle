import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/presentation/screens/create_profile/age.dart';
import 'package:lifestyle/presentation/screens/create_profile/gender.dart';
import 'package:lifestyle/presentation/screens/create_profile/tags.dart';
import 'package:lifestyle/presentation/screens/create_profile/weight.dart';
import 'package:lifestyle/presentation/screens/main_screen.dart';
import 'package:lifestyle/presentation/widgets/dots_indicator.dart';

import '../../../common/constants/colors.dart';
import '../../../common/constants/constants.dart';
import 'height.dart';

class CreateProfile extends StatefulWidget {
  CreateProfile({Key? key}) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: DotsIndicator(
          position: AppVariables.currentPosition,
          decorator: DotsDecorator(
            size: const Size(28.0, 5.0),
            spacing: EdgeInsets.only(right: 5),
            activeSize: const Size(28.0, 5.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
          dotsCount: 5,
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => MainScreen()));
                },
                icon: FaIcon(
                  FontAwesomeIcons.xmark,
                  color: AppColors.contrast,
                ),
              ),
            ),
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: CarouselSlider(
          items: [
            GenderScreen(
              controlToNext: () {
                return controller.nextPage();
              },
            ),
            AgeScreen(controlToNext: () {
             return controller.nextPage();
            }, controlToPrev: () {
              controller.previousPage();
            }),
            HeightScreen(controlToNext: () {
             return controller.nextPage();
            }, controlToPrev: () {
              controller.previousPage();
            }),
            WeightScreen(controlToNext: () {
              return controller.nextPage();
            }, controlToPrev: () {
              controller.previousPage();
            }),
            TagsScreen(controlToPrev: () {
              controller.previousPage();
            }),
          ],
          carouselController: controller,
          options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              enableInfiniteScroll: false,
              viewportFraction: 1,
              scrollPhysics: NeverScrollableScrollPhysics(),
              onScrolled: (item) {
                double _validPosition(double position) {
                  if (position >= 5) return 0;
                  if (position < 0) {
                    return 5 - 1.0;
                  }
                  return position;
                }

                _updatePosition(double position) {
                  setState(() =>
                      AppVariables.currentPosition = _validPosition(position));
                }

                _updatePosition(item!);
              }),
        ),
      ),
    );
  }
}
