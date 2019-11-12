import 'dart:async';

import 'package:better_help/common/auth0/google_auth.dart';
import 'package:better_help/common/data/dao/user_dao.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

class Auth {
    static bool firstTimeSignIn = false;
    
    static final _auth = FirebaseAuth.instance;
    
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
        return user;
    }
    
    static Stream<FirebaseUser> get firebaseUserStream =>
        _auth.onAuthStateChanged;
    
    static Future<void> beOffline() async {
        final user = await currentUser();
        if (user != null) {
            UserDao.updateUser(id: user.id, fields: {'online': false});
        }
    }
    
    static Future<void> beOnline() async {
        final user = await currentUser();
        if (user != null) {
            UserDao.updateUser(
                id: user.id, fields: {'online': true});
        }
    }
    
    static Future<void> addDeviceToken({@required String userId, @required String token,}) async {
        final user = await currentUser();
        if (user != null) {
            final tokens = user.tokens ?? <String>[];
            if (!user.tokens.contains(token)) {
                tokens.add(token);
                UserDao.updateUser(id: userId, fields: {'tokens': tokens});
            }
        }
    }
}
