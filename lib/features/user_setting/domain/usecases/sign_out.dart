import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

class SignOut {
  final GoogleSignIn googleSignIn;

  SignOut({@required this.googleSignIn});

  void call() {
    FirebaseAuth.instance.signOut();
    googleSignIn.signOut();
  }
}
