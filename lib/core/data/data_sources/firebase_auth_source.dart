import 'package:better_help/core/data/models/user_model.dart';
import 'package:better_help/core/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthSource {
  final firebaseAuth = FirebaseAuth.instance;

  final _userCollection = Firestore.instance.collection('users');

  Future<User> getCurrentUser() async {
    final fUser = await firebaseAuth.currentUser();
    if (fUser != null) {
      final doc = await _userCollection.document(fUser.uid).get();
      return UserModel.fromJson(doc.data);
    } else {
      return null;
    }
  }
}
