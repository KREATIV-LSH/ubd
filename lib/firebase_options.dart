// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDRCUl2y2lwEjWb33eBiAEwd8Al9APa6WI',
    appId: '1:374731504843:web:7c5bd1c16f15a9ecee6f4e',
    messagingSenderId: '374731504843',
    projectId: 'ubd-rechner',
    authDomain: 'ubd-rechner.firebaseapp.com',
    storageBucket: 'ubd-rechner.appspot.com',
    measurementId: 'G-60VVYWX1F6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDhQ6JFdYaKC7BGczz8VGf4dPwqPGuGuGU',
    appId: '1:374731504843:android:7166c2676900b503ee6f4e',
    messagingSenderId: '374731504843',
    projectId: 'ubd-rechner',
    storageBucket: 'ubd-rechner.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB7SkMs1wFQ3q75Ulb-A_kOT4JRbJhPmT4',
    appId: '1:374731504843:ios:499eb85409403883ee6f4e',
    messagingSenderId: '374731504843',
    projectId: 'ubd-rechner',
    storageBucket: 'ubd-rechner.appspot.com',
    iosBundleId: 'com.example.ubd',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB7SkMs1wFQ3q75Ulb-A_kOT4JRbJhPmT4',
    appId: '1:374731504843:ios:499eb85409403883ee6f4e',
    messagingSenderId: '374731504843',
    projectId: 'ubd-rechner',
    storageBucket: 'ubd-rechner.appspot.com',
    iosBundleId: 'com.example.ubd',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDRCUl2y2lwEjWb33eBiAEwd8Al9APa6WI',
    appId: '1:374731504843:web:429426fd7458242fee6f4e',
    messagingSenderId: '374731504843',
    projectId: 'ubd-rechner',
    authDomain: 'ubd-rechner.firebaseapp.com',
    storageBucket: 'ubd-rechner.appspot.com',
    measurementId: 'G-ZK186NPTR9',
  );
}
