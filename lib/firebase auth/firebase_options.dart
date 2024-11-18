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
    apiKey: 'AIzaSyDrqwQxAN5XZqcTfx_x8ViKuuyFLkZd0DM',
    appId: '1:232490901330:web:dea3e1670c521b100da48b',
    messagingSenderId: '232490901330',
    projectId: 'halle-s-dining-food-order-app',
    authDomain: 'halle-s-dining-food-order-app.firebaseapp.com',
    storageBucket: 'halle-s-dining-food-order-app.appspot.com',
    measurementId: 'G-1GC1RS2CGT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD53D-v8pMdgFRiisBengteEs6kJQUO6Qg',
    appId: '1:232490901330:android:99ba0f20794236420da48b',
    messagingSenderId: '232490901330',
    projectId: 'halle-s-dining-food-order-app',
    storageBucket: 'halle-s-dining-food-order-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0ceKWTAvcesm28uRJOkoE3cK2LQKFb5g',
    appId: '1:232490901330:ios:547e79f0856c2feb0da48b',
    messagingSenderId: '232490901330',
    projectId: 'halle-s-dining-food-order-app',
    storageBucket: 'halle-s-dining-food-order-app.appspot.com',
    iosBundleId: 'com.example.foodDeliveryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD0ceKWTAvcesm28uRJOkoE3cK2LQKFb5g',
    appId: '1:232490901330:ios:547e79f0856c2feb0da48b',
    messagingSenderId: '232490901330',
    projectId: 'halle-s-dining-food-order-app',
    storageBucket: 'halle-s-dining-food-order-app.appspot.com',
    iosBundleId: 'com.example.foodDeliveryApp',
  );
}