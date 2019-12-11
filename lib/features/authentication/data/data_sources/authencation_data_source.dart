import 'package:better_help/core/data/models/user_model.dart';
import 'package:better_help/core/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthenticationDataSource {
  Future<User> getUser(String id);

  Future<void> createUser(User user);
}

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  final _userCollection = Firestore.instance.collection('users');

  @override
  Future<User> getUser(String id) async {
    final doc = await _userCollection.document(id).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data);
    } else {
      return null;
    }
  }

  @override
  Future<void> createUser(User user) => _userCollection
      .document(user.id)
      .setData(UserModel.fromUser(user).toJson());
}
