import 'package:firebase_core/firebase_core.dart';

class FirebaseInitialization {
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
}
