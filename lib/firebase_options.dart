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
    apiKey: 'AIzaSyC3YfXy_oiEYVxLgoM4bzAAy7R7sPurAU0',
    appId: '1:530693066891:web:fcb9406580a4a93538448e',
    messagingSenderId: '530693066891',
    projectId: 'split-the-bill-flutter-99eeb',
    authDomain: 'split-the-bill-flutter-99eeb.firebaseapp.com',
    storageBucket: 'split-the-bill-flutter-99eeb.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDv9ZCF_K58kaPBzDnWCwMfM3KEGr0aOFI',
    appId: '1:530693066891:android:c85697fbf58cb1e038448e',
    messagingSenderId: '530693066891',
    projectId: 'split-the-bill-flutter-99eeb',
    storageBucket: 'split-the-bill-flutter-99eeb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBgUFb_ZFn8M9SfvWUPVsP40-WJ2E4Gz68',
    appId: '1:530693066891:ios:10a0b80de55e3dc438448e',
    messagingSenderId: '530693066891',
    projectId: 'split-the-bill-flutter-99eeb',
    storageBucket: 'split-the-bill-flutter-99eeb.appspot.com',
    iosBundleId: 'com.example.splitTheBill',
  );
}
