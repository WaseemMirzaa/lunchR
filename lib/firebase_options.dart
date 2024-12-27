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
    apiKey: 'AIzaSyB5eFlMDUqOhgl08kBIE5YkzvjppoVAIXo',
    appId: '1:117032118353:web:f246801aebc692c20f3070',
    messagingSenderId: '117032118353',
    projectId: 'luncher-86d25',
    authDomain: 'luncher-86d25.firebaseapp.com',
    storageBucket: 'luncher-86d25.firebasestorage.app',
    measurementId: 'G-9DB1Q66S6E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDF2KBRjQVMTcLxtDliccAOLNMEqgOsad4',
    appId: '1:117032118353:android:f8dd4e2972e3e2930f3070',
    messagingSenderId: '117032118353',
    projectId: 'luncher-86d25',
    storageBucket: 'luncher-86d25.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDVweqgPrKRZZK7tQXbkvC5LqJPPUVVDBk',
    appId: '1:117032118353:ios:232206dcba23974e0f3070',
    messagingSenderId: '117032118353',
    projectId: 'luncher-86d25',
    storageBucket: 'luncher-86d25.firebasestorage.app',
    iosBundleId: 'com.example.luncher',
  );
}
