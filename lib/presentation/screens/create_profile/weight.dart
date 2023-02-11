import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifestyle/presentation/bloc/create_profile/weight/weight_cubit.dart';
import 'package:lifestyle/presentation/widgets/create_profile_body.dart';

import '../../../common/constants/constants.dart';
import '../../../common/services/service_locator.dart';

class WeightScreen extends StatelessWidget {
  final Future<void> Function() controlToNext;
  final Function()? controlToPrev;

  WeightScreen({
    Key? key,
    required this.controlToNext,
    this.controlToPrev,
  }) : super(key: key);
  List _items = List.generate(80, (index) => 40 + index);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WeightCubit>(),
      child: Scaffold(
        body: BlocBuilder<WeightCubit, WeightState>(
          builder: (context, state) {
            return CreateProfileBody(
              title: AppText.whatsWeight,
              buttonTitle: AppText.next,
              content: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                  height: 250,
                  width: 150,
                  color: Colors.white,
                  child: CupertinoPicker(
                    selectionOverlay: SizedBox(),
                    diameterRatio: 1.5,
                    squeeze: 1,
                    magnification: 1.5,
                    itemExtent: 45.0,
                    onSelectedItemChanged: (value) {
                      context.read<WeightCubit>().setWeight(_items[value]);
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
                    .read<WeightCubit>()
                    .accept(state.weight!)
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
