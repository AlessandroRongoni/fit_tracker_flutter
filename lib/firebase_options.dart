// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
// ignore: depend_on_referenced_packages
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
    apiKey: 'AIzaSyBumqPM-z1XoShIPUKSsEOM0M900mRQTQ8',
    appId: '1:381873182603:android:93d28cc86a57c957ea418e',
    messagingSenderId: '381873182603',
    projectId: 'fittrackerflutter',
    databaseURL: 'https://fittrackerflutter-default-rtdb.firebaseio.com',
    storageBucket: 'fittrackerflutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAcdgPSjgcVhyev7-UxuQMLJtt0gJAkdMA',
    appId: '1:381873182603:ios:879ce466fd214d48ea418e',
    messagingSenderId: '381873182603',
    projectId: 'fittrackerflutter',
    databaseURL: 'https://fittrackerflutter-default-rtdb.firebaseio.com',
    storageBucket: 'fittrackerflutter.appspot.com',
    iosClientId: '381873182603-v5dl13fds7h22q8bn6u6avujvpc8315b.apps.googleusercontent.com',
    iosBundleId: 'com.example.fitTrackerFlutter',
  );
}