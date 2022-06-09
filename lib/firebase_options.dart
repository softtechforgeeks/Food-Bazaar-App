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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDC3B6vGJmwMNPyr9wavICNt9ELRS9S0no',
    appId: '1:883407828382:web:2a32efb3ae3cc3a08f928f',
    messagingSenderId: '883407828382',
    projectId: 'food-bazar-app',
    authDomain: 'food-bazar-app.firebaseapp.com',
    storageBucket: 'food-bazar-app.appspot.com',
    measurementId: 'G-5ZZ1XNMX8F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTYmgTG9T1THc755NGpr2ZkgEXXu0CbwA',
    appId: '1:883407828382:android:e5b6a435e3f21b588f928f',
    messagingSenderId: '883407828382',
    projectId: 'food-bazar-app',
    storageBucket: 'food-bazar-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDaZLWhUCL6ZA2sPeR-3piNZS5e9wpg1iI',
    appId: '1:883407828382:ios:cb3bba60eb30a8dd8f928f',
    messagingSenderId: '883407828382',
    projectId: 'food-bazar-app',
    storageBucket: 'food-bazar-app.appspot.com',
    iosClientId: '883407828382-c5m84ejc6sn1vfud0ulj0snaej8dp8qs.apps.googleusercontent.com',
    iosBundleId: 'net.fluttertutorial.flutterLoginUi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDaZLWhUCL6ZA2sPeR-3piNZS5e9wpg1iI',
    appId: '1:883407828382:ios:89a02b6274f791938f928f',
    messagingSenderId: '883407828382',
    projectId: 'food-bazar-app',
    storageBucket: 'food-bazar-app.appspot.com',
    iosClientId: '883407828382-pkvhlmnksdp7602k1c797i17q8v1lcp5.apps.googleusercontent.com',
    iosBundleId: 'com.mobilemaster.foodbazarapp',
  );
}
