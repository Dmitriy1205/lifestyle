import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifestyle/presentation/bloc/create_profile/weight/weight_cubit.dart';
import 'package:lifestyle/presentation/widgets/create_profile_body.dart';

import '../../../common/constants/constants.dart';
import '../../../common/services/service_locator.dart';

class WeightScreen extends StatelessWidget {
  final Future<void> Function()? controlToNext;
  final Function()? controlToPrev;
  final Function()? edit;
  final bool fromProfile;
  final int? weight;

  WeightScreen({
    Key? key,
    this.controlToNext,
    this.controlToPrev,
    this.edit,
    this.fromProfile = false, this.weight,
  }) : super(key: key);
  final List _items = List.generate(80, (index) => 40 + index);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WeightCubit>(),
      child: Scaffold(
        body: BlocBuilder<WeightCubit, WeightState>(
          builder: (context, state) {
            return CreateProfileBody(
              fromProfile: fromProfile,
              title: AppText.whatsWeight,
              buttonTitle: AppText.next,
              content: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width / 2.5,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        flex: 3,
                        child: CupertinoPicker(
                          scrollController: FixedExtentScrollController(initialItem: weight == null ? 0: weight!-40 ),
                          selectionOverlay: const SizedBox(),
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
                      const Text(
                        'kg',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTapNext: () {
                return context
                    .read<WeightCubit>()
                    .accept(state.weight!)
                    .then((value) => controlToNext!());
              },
              onTapPrev: controlToPrev,
              onEdit: () {
                return context
                    .read<WeightCubit>()
                    .accept(state.weight!)
                    .then((value) => Navigator.pop(context));
              },
            );
          },
        ),
      ),
    );
  }
}
