import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common/services/service_locator.dart' as sl;
import 'presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kReleaseMode && Platform.isIOS) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
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
  runApp(const App());
}
