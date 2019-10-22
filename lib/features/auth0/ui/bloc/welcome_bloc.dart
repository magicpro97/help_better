import 'dart:async';
import 'dart:developer';

import 'package:better_help/common/data/dao/user_dao.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'bloc.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  WelcomeBloc() {
    _auth.onAuthStateChanged.listen((firebaseUser) async {
      if (firebaseUser != null) {
        final user = await UserDao.findById(firebaseUser.uid);
        if (user == null) {
          final newUser = User(
              id: firebaseUser.uid,
              displayName: firebaseUser.displayName,
              email: firebaseUser.email,
              photoUrl: firebaseUser.photoUrl,
              types: [UserType.NORMAL],
              created: DateTime.now());
          UserDao.addUser(newUser);
        }
      }
    });
  }

  @override
  WelcomeState get initialState => CheckSignInState();

  @override
  Stream<WelcomeState> mapEventToState(
    WelcomeEvent event,
  ) async* {
    if (event is SignInEvent) {
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
      );
      try {
        final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        _auth.signInWithCredential(credential);
      } catch (error) {
        log(error.toString());
        yield SignInFailState();
      }
    } else if (event is CheckSignInStateEvent) {
       final user = await _auth.currentUser();
       if (user != null) {
         yield SignedState();
       }
    }
  }
}
