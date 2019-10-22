import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  static const List<String> _googleSignInScope = const [
    'email',
    //'https://www.googleapis.com/auth/contacts.readonly',
  ];

  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: _googleSignInScope,
  );

  static Future<GoogleSignInAccount> getSignedInAccount() async {
    GoogleSignInAccount account = _googleSignIn.currentUser;
    if (account == null) {
      try {
        account = await _googleSignIn.signIn();
      } catch (error) {
        log(error.toString());
        return null;
      }
    }
    log(account.displayName);
    return account;
  }

  static Future<GoogleSignInAccount> signOut() => _googleSignIn.signOut();

  static Future<GoogleSignInAccount> disconnect() => _googleSignIn.disconnect();

  static GoogleSignInAccount get currentUser => _googleSignIn.currentUser;
}
