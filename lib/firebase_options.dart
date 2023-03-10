// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAzY6lqGDGt1y8dZ__EqenjseKMhRaVoME',
    appId: '1:1076669634018:android:869649757bb04717ae55bb',
    messagingSenderId: '1076669634018',
    projectId: 'lifestyle-e8a2d',
    storageBucket: 'lifestyle-e8a2d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBBiPpG_X9pqPeBykda4c_TiTQqOZLi4So',
    appId: '1:1076669634018:ios:3180757f9623ba5eae55bb',
    messagingSenderId: '1076669634018',
    projectId: 'lifestyle-e8a2d',
    storageBucket: 'lifestyle-e8a2d.appspot.com',
    androidClientId: '1076669634018-r4nim8872i3ligooobajkf0u7b7aip4r.apps.googleusercontent.com',
    iosClientId: '1076669634018-veiu8dkpck6da8u0vkah5hsinmm0g950.apps.googleusercontent.com',
    iosBundleId: 'com.example.lifestyle',
  );
}
