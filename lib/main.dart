import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'common/services/service_locator.dart' as sl;
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kReleaseMode && Platform.isIOS) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBBiPpG_X9pqPeBykda4c_TiTQqOZLi4So',
        appId: 'com.shea.lifestyle',
        messagingSenderId: '',
        projectId: 'lifestyle-e8a2d',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await sl.init();

  // // Create customized instance which can be registered via dependency injection
  // final InternetConnectionChecker customInstance =
  //     InternetConnectionChecker.createInstance(
  //   checkTimeout: const Duration(seconds: 1),
  //   checkInterval: const Duration(seconds: 1),
  // );
  //
  // // Check internet connection with created instance
  // await execute(customInstance);
  runApp(const App());
}

Future<void> execute(

) async {
  final StreamSubscription<InternetConnectionStatus> listener =
      InternetConnectionChecker().onStatusChange.listen(
    (InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          break;
        case InternetConnectionStatus.disconnected:
          break;
      }
    },
  );

  // close listener after 30 seconds, so the program doesn't run forever
  await Future<void>.delayed(const Duration(seconds: 30));
  await listener.cancel();
}
