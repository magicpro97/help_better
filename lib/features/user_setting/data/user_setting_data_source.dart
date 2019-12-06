import 'dart:async';
import 'dart:developer';

import 'package:better_help/core/error/exception.dart';
import 'package:better_help/features/user_setting/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserSettingDataSource {
  Future<void> updateUser(UserModel user);

  Future<UserModel> getUser(String id);
}

class UserSettingDataSourceImpl implements UserSettingDataSource {
  CollectionReference get _userCollection =>
      Firestore.instance.collection('users');

  @override
  Future<void> updateUser(UserModel user) {
    log(user.id);
    return _userCollection.document(user.id).updateData(user.toJson());
  }

  @override
  Future<UserModel> getUser(String id) async {
    final doc = await _userCollection.document(id).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data);
    } else {
      throw DatabaseException();
    }
  }
}
