import 'package:better_help/core/data/models/user_model.dart';
import 'package:better_help/core/data/tranformer/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserDataSource {
  Future<UserModel> getUser(String id);

  Stream<UserModel> getUserStream(String id);

  Future<List<UserModel>> getUserFriends(String userId);

  Future<void> update(UserModel user);
}

class UserDataSourceImpl implements UserDataSource {
  final _userCollection = Firestore.instance.collection('users');

  @override
  Future<UserModel> getUser(String id) async =>
      UserModel.fromJson((await _userCollection.document(id).get()).data);

  @override
  Stream<UserModel> getUserStream(String id) =>
      _userCollection.document(id).snapshots().transform(toUser);

  @override
  Future<List<UserModel>> getUserFriends(String userId) async =>
      (await _userCollection
              .where('friendIds', arrayContains: userId)
              .getDocuments())
          .documents
          .map((doc) => UserModel.fromJson(doc.data))
          .toList();

  @override
  Future<void> update(UserModel user) =>
      _userCollection.document(user.id).updateData(user.toJson());
}
