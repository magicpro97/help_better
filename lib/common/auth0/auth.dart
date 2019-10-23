import 'dart:async';

import 'package:better_help/common/auth0/google_auth.dart';
import 'package:better_help/common/data/dao/user_dao.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  static final _auth = FirebaseAuth.instance;

  static Future<User> currentUser() async {
    final firebaseUser = await _auth.currentUser();
    return await UserDao.findById(firebaseUser.uid);
  }

  static Future<bool> isNewUser() async {
    final firebaseUser = await _auth.currentUser();
    return await UserDao.findById(firebaseUser.uid) == null;
  }

  static Future<User> createUser() async {
    final firebaseUser = await _auth.currentUser();
    final newUser = User(
        id: firebaseUser.uid,
        displayName: firebaseUser.displayName,
        email: firebaseUser.email,
        photoUrl: firebaseUser.photoUrl,
        types: [UserType.NORMAL],
        created: DateTime.now());
    UserDao.addUser(newUser);
    return newUser;
  }

  static Future<void> signOut() async {
    await _auth.signOut();
    await GoogleAuth.signOut();
  }

  static Stream<FirebaseUser> get userStream => _auth.onAuthStateChanged;

  static Future<User> signIn() async {
    final googleUser = await GoogleAuth.getSignedInAccount();
    if (googleUser == null) return null;
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _auth.signInWithCredential(credential);
    final firebaseUser = authResult.user;
    final user = await UserDao.findById(firebaseUser.uid);
    return user;
  }
}
