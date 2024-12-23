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
    apiKey: 'AIzaSyBQg9uxz-dXLwvmlxMKkr2nY6e_YLxt3AE',
    appId: '1:978742854763:web:68398a35520155e777dd2e',
    messagingSenderId: '978742854763',
    projectId: 'chat-application-ee8d7',
    authDomain: 'chat-application-ee8d7.firebaseapp.com',
    storageBucket: 'chat-application-ee8d7.firebasestorage.app',
    measurementId: 'G-VXFJWMZEC3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAMlkNqj0_U-AMN8qxBl0OzbNHRRcA2Ze8',
    appId: '1:978742854763:android:81f78de5f95a53bb77dd2e',
    messagingSenderId: '978742854763',
    projectId: 'chat-application-ee8d7',
    storageBucket: 'chat-application-ee8d7.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBG-tJjUbjCXbF-wai4g9sEZVAI6HSw2Vo',
    appId: '1:978742854763:ios:f7f18e0bb994bb5c77dd2e',
    messagingSenderId: '978742854763',
    projectId: 'chat-application-ee8d7',
    storageBucket: 'chat-application-ee8d7.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBG-tJjUbjCXbF-wai4g9sEZVAI6HSw2Vo',
    appId: '1:978742854763:ios:f7f18e0bb994bb5c77dd2e',
    messagingSenderId: '978742854763',
    projectId: 'chat-application-ee8d7',
    storageBucket: 'chat-application-ee8d7.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBQg9uxz-dXLwvmlxMKkr2nY6e_YLxt3AE',
    appId: '1:978742854763:web:27deb48ed3932b1177dd2e',
    messagingSenderId: '978742854763',
    projectId: 'chat-application-ee8d7',
    authDomain: 'chat-application-ee8d7.firebaseapp.com',
    storageBucket: 'chat-application-ee8d7.firebasestorage.app',
    measurementId: 'G-6CQP1RNNK4',
  );
}