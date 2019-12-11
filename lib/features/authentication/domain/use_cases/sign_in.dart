import 'dart:developer';

import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/core/error/failure.dart';
import 'package:better_help/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

class SignIn {
  bool firstTimeSignIn = true;

  //final _googleSignIn = GoogleSignIn(scopes: ['email']);
  final _auth = FirebaseAuth.instance;

  final AuthenticationRepository repository;
  final GoogleSignIn googleSignIn;

  SignIn({@required this.googleSignIn, @required this.repository});

  Future<User> signIn() async {
    firstTimeSignIn = false;
    final googleUser = await getSignedInAccount();
    if (googleUser == null) throw SignInFailure();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _auth.signInWithCredential(credential);
    final firebaseUser = authResult.user;
    final user = await repository.getUser(firebaseUser.uid);
    return user;
  }

  Future<GoogleSignInAccount> getSignedInAccount() async {
    GoogleSignInAccount account = googleSignIn.currentUser;
    if (account == null) {
      try {
        account = await googleSignIn.signIn();
      } catch (error) {
        log(error.toString());
        return null;
      }
    }
    log(account.displayName);
    return account;
  }

  Future<User> call() async {
    final currentUser = await repository.getCurrentUser();
    if (currentUser != null) {
      firstTimeSignIn = false;
      final googleUser = await getSignedInAccount();
      if (googleUser == null) throw Exception('google user null');
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final authResult = await _auth.signInWithCredential(credential);
      final firebaseUser = authResult.user;
      return await repository.getUser(firebaseUser.uid);
    }
    return null;
  }
}
