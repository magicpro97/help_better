import 'dart:async';

import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/data/tranformer/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDao {
  static const String USERS = 'users';
  static final _store = Firestore.instance.collection(USERS);

  static Future<void> addUser(User user) =>
      _store.document(user.id).setData(user.toJson());

  static Future<User> findById(String id) async {
    final doc = await _store.document(id).get();
    if (doc.exists) return User.fromJson(doc.data);
    return null;
  }

  static Stream<List<User>> userListStream() =>
      _store.snapshots().transform(toListUser);
}
