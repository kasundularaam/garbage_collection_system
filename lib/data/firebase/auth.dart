import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  static signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          throw "Anonymous auth hasn't been enabled for this project.";
        default:
          throw "Unknown error.";
      }
    }
  }

  static signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw e.toString();
    }
  }
}
