import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifestyle/presentation/bloc/create_profile/age/age_cubit.dart';
import 'package:lifestyle/presentation/widgets/create_profile_body.dart';

import '../../../common/constants/constants.dart';
import '../../../common/services/service_locator.dart';
import '../../widgets/connection_message.dart';

class AgeScreen extends StatelessWidget {
  final Future<void> Function()? controlToNext;
  final Function()? controlToPrev;
  final bool fromProfile;
  final int? age;
  final bool? disconnected;

  AgeScreen({
    Key? key,
    this.controlToNext,
    this.controlToPrev,
    this.fromProfile = false,
    this.age,
    this.disconnected,
  }) : super(key: key);

  final List _items = List.generate(43, (index) => 18 + index);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AgeCubit>(),
      child: Scaffold(
        body: BlocBuilder<AgeCubit, AgeState>(
          builder: (context, state) {
            return CreateProfileBody(
              fromProfile: fromProfile,
              title: AppText.howOld,
              content: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                  height: 250,
                  width: 150,
                  color: Colors.white,
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                        initialItem: age == null ? 0 : age! - 18),
                    selectionOverlay: const SizedBox(),
                    diameterRatio: 1.5,
                    squeeze: 1,
                    magnification: 1.5,
                    itemExtent: 45.0,
                    onSelectedItemChanged: (value) {
                      context.read<AgeCubit>().setAge(_items[value]);
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
              buttonTitle: AppText.next,
              onTapNext: () {
                return context
                    .read<AgeCubit>()
                    .accept(state.age!)
                    .then((value) => controlToNext!());
              },
              onTapPrev: controlToPrev,
              onEdit: () {
                return !disconnected!
                    ? ConnectionMessage.buildDisconnectedSnackbar(context)
                    : context
                        .read<AgeCubit>()
                        .accept(state.age!)
                        .then((value) => Navigator.pop(context));
              },
            );
          },
        ),
      ),
    );
  }
}
