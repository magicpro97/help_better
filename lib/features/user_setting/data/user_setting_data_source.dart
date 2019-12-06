import 'dart:async';

import 'package:better_help/core/error/exception.dart';
import 'package:better_help/features/user_setting/data/models/user_model.dart';
import 'package:better_help/features/user_setting/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserSettingDataSource {
  Stream<User> getUserStream(String id);

  Future<void> updateUser(User user);

  Future<User> getUser(String id);
}

class UserSettingDataSourceImpl implements UserSettingDataSource {
  CollectionReference get _userCollection =>
      Firestore.instance.collection('users');

  StreamTransformer<DocumentSnapshot, User> get toUser =>
      StreamTransformer.fromHandlers(
        handleData: (data, sink) => sink.add(UserModel.fromJson(data.data)),
      );

  @override
  Future<void> updateUser(User user) =>
      _userCollection.document(user.id).setData((user as UserModel).toJson());

  @override
  Stream<User> getUserStream(String id) =>
      _userCollection.document(id).snapshots().transform(toUser);

  @override
  Future<User> getUser(String id) async {
    final doc = await _userCollection.document(id).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data);
    } else {
      throw DatabaseException();
    }
  }
}
