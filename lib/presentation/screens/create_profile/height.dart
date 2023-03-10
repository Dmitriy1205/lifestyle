import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifestyle/presentation/widgets/create_profile_body.dart';

import '../../../common/constants/constants.dart';
import '../../../common/services/service_locator.dart';
import '../../bloc/create_profile/height/height_cubit.dart';
import '../../widgets/connection_message.dart';

class HeightScreen extends StatelessWidget {
  final Future<void> Function()? controlToNext;
  final Function()? controlToPrev;
  final bool fromProfile;
  final int? height;
  final bool? disconnected;

  HeightScreen({
    Key? key,
    this.controlToNext,
    this.controlToPrev,
    this.fromProfile = false,
    this.height,
    this.disconnected,
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
              fromProfile: fromProfile,
              title: AppText.whatsHeight,
              buttonTitle: AppText.next,
              content: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width / 2,
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
                          scrollController: FixedExtentScrollController(
                              initialItem: height == null ? 0 : height! - 140),
                          selectionOverlay: const SizedBox(),
                          diameterRatio: 1.5,
                          squeeze: 1,
                          magnification: 1.5,
                          itemExtent: 45.0,
                          onSelectedItemChanged: (value) {
                            context
                                .read<HeightCubit>()
                                .setHeight(_items[value]);
                          },
                          children: List.generate(_items.length, (index) {
                            return Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 15, 0),
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
                        'cm',
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
                    .read<HeightCubit>()
                    .accept(state.height!)
                    .then((value) => controlToNext!());
              },
              onTapPrev: controlToPrev,
              onEdit: () {
                return !disconnected!
                    ? ConnectionMessage.buildDisconnectedSnackbar(context)
                    : context
                        .read<HeightCubit>()
                        .accept(state.height!)
                        .then((value) => Navigator.pop(context));
              },
            );
          },
        ),
      ),
    );
  }
}
