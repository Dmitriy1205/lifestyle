import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifestyle/presentation/widgets/create_profile_body.dart';

import '../../../common/constants/constants.dart';
import '../../../common/services/service_locator.dart';
import '../../bloc/create_profile/height/height_cubit.dart';

class HeightScreen extends StatelessWidget {
  final Future<void> Function() controlToNext;
  final Function()? controlToPrev;

  HeightScreen({
    Key? key,
    required this.controlToNext,
    this.controlToPrev,
  }) : super(key: key);
  final List _items = List.generate(60, (index) => 140 + index);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HeightCubit>(),
      child: Scaffold(
        body: BlocBuilder<HeightCubit, HeightState>(
          builder: (context, state) {
            return CreateProfileBody(
              title: AppText.whatsHeight,
              buttonTitle: AppText.next,
              content: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                  height: 250,
                  width: 150,
                  color: Colors.white,
                  child: CupertinoPicker(
                    selectionOverlay: const SizedBox(),
                    diameterRatio: 1.5,
                    squeeze: 1,
                    magnification: 1.5,
                    itemExtent: 45.0,
                    onSelectedItemChanged: (value) {
                      context.read<HeightCubit>().setHeight(_items[value]);
                    },
                    children: List.generate(_items.length, (index) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                          child: Text(
                            _items[index].toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              onTapNext: () {
                return context
                    .read<HeightCubit>()
                    .accept(state.height!)
                    .then((value) => controlToNext());
              },
              onTapPrev: controlToPrev,
            );
          },
        ),
      ),
    );
  }
}
