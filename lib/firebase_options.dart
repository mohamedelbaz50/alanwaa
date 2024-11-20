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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBbC-WT0wKFWTWNnqPWH91lU0g3pQmt3TI',
    appId: '1:774579093093:web:bb7045a9c8d73edf34108c',
    messagingSenderId: '774579093093',
    projectId: 'samer-weather-app',
    authDomain: 'samer-weather-app.firebaseapp.com',
    storageBucket: 'samer-weather-app.appspot.com',
    measurementId: 'G-WPBWMCE4HL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6qCGCSQeOc--_jvFC5KERp0nA_QwA02k',
    appId: '1:774579093093:android:0534e792768e772434108c',
    messagingSenderId: '774579093093',
    projectId: 'samer-weather-app',
    storageBucket: 'samer-weather-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCVA-T824Mfe9N7QYs2VBKy6PNsfs19DRU',
    appId: '1:774579093093:ios:0b5c06a79fb176c134108c',
    messagingSenderId: '774579093093',
    projectId: 'samer-weather-app',
    storageBucket: 'samer-weather-app.appspot.com',
    iosBundleId: 'com.example.app',
  );
}
