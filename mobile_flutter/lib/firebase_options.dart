// Temporary Firebase options placeholder for Android only.
// Replace with a proper generated file by running `flutterfire configure`.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
            'DefaultFirebaseOptions are not supported for this platform. Run `flutterfire configure` to generate platform options.');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZ8axane09hg42Tf5JbWhWRRUzWn7qm-E',
    appId: '1:709825500142:android:e62f8d5783bf2b356234ff',
    messagingSenderId: '709825500142',
    projectId: 'exam-8a788',
    storageBucket: 'exam-8a788.firebasestorage.app',
  );
}
