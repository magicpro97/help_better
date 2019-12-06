import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:better_help/common/auth0/google_auth.dart';
import 'package:better_help/common/data/dao/user_dao.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

class Auth {
  static bool firstTimeSignIn = true;

  static final _auth = FirebaseAuth.instance;

  static final _fcm = FirebaseMessaging();

  static Future<User> currentUser() async {
    final firebaseUser = await _auth.currentUser();
    return firebaseUser != null
        ? await UserDao.findById(firebaseUser.uid)
        : null;
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
        online: true,
        needs: null,
        types: [UserType.NORMAL],
        created: DateTime.now());
    await UserDao.addUser(newUser);
    return newUser;
  }

  static Future<void> signOut() async {
    await beOffline();
    await _auth.signOut();
    await GoogleAuth.signOut();
  }

  static Future<User> signIn() async {
    firstTimeSignIn = false;
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
    await beOnline();
    getDeviceToken();
    return user;
  }

  static Stream<FirebaseUser> get firebaseUserStream =>
      _auth.onAuthStateChanged;

  static Future<void> beOffline() async {
    final user = await currentUser();
    if (user != null) {
      final json = user.toJson();
      json['online'] = false;
      UserDao.updateUser(user: User.fromJson(json));
    }
  }

  static Future<void> beOnline() async {
    final user = await currentUser();
    if (user != null) {
      final json = user.toJson();
      json['online'] = true;
      UserDao.updateUser(user: User.fromJson(json));
    }
  }

  static Future<void> addDeviceToken({
    @required String token,
  }) async {
    final user = await currentUser();
    if (user != null) {
      if (user.tokens == null) {
        final json = user.toJson();
        json['tokens'] = [token];
        UserDao.updateUser(user: User.fromJson(json));
      } else {
        user.tokens.add(token);
        UserDao.updateUser(user: user);
      }
    }
  }

  static void getDeviceToken() {
    if (Platform.isIOS) {
      _fcm.onIosSettingsRegistered.listen((data) {
        log(data.toString());
        _fcm.getToken().then((token) => addDeviceToken(token: token));

        _fcm.requestNotificationPermissions();
      });
    } else {
      _fcm.getToken().then((token) => addDeviceToken(token: token));
    }
  }

  static final fcmConfigure = _fcm.configure;

  static Future<dynamic> messageBackground(Map<String, dynamic> message) async {
    log(message.toString(), name: 'Backgroud Message');
  }

  static Future<Stream<User>> currentUserStream() async {
    final user = await currentUser();
    return UserDao.userStream(user.id);
  }
}
