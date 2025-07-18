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
    apiKey: 'AIzaSyCH4nniXS7logI0kZ6p4gdoCCoegqWExnw',
    appId: '1:289961247348:web:7388f3dd65505b7a6dc721',
    messagingSenderId: '289961247348',
    projectId: 'fixerhub-f7701',
    authDomain: 'fixerhub-f7701.firebaseapp.com',
    storageBucket: 'fixerhub-f7701.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA3ekdtUbCTiBjipCt6EMWYTuOnxFd1oMk',
    appId: '1:289961247348:android:a5564e56629bf9bf6dc721',
    messagingSenderId: '289961247348',
    projectId: 'fixerhub-f7701',
    storageBucket: 'fixerhub-f7701.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCghZhuNCBl6HFBWDNtqi-Y1f8AiOutKXU',
    appId: '1:289961247348:ios:2fa824b3534e30956dc721',
    messagingSenderId: '289961247348',
    projectId: 'fixerhub-f7701',
    storageBucket: 'fixerhub-f7701.firebasestorage.app',
    androidClientId: '289961247348-9vt9l6s5vj04enhha69ro3pacf5doq9q.apps.googleusercontent.com',
    iosClientId: '289961247348-9u9ntobckoibtembbheqleobar16g4og.apps.googleusercontent.com',
    iosBundleId: 'com.example.fixerhub',
  );

}