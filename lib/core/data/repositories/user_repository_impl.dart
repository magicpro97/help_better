import 'package:better_help/core/data/data_sources/user_data_source.dart';
import 'package:better_help/core/data/models/user_model.dart';
import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/core/domain/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;
  final firebaseAuth = FirebaseAuth.instance;

  UserRepositoryImpl({@required this.userDataSource});

  @override
  Future<User> get(String id) => userDataSource.getUser(id);

  @override
  Stream<User> getStream(String id) => userDataSource.getUserStream(id);

  @override
  Future<List<User>> getUserFriends(String id) =>
      userDataSource.getUserFriends(id);

  @override
  Future<void> updateUser(User user) async {
    if (user != null) {
      userDataSource.update(UserModel.fromUser(user));
    } else {
      throw ArgumentError.notNull('User is not null');
    }
  }

  @override
  Future<void> createUser(User user) =>
      userDataSource.createUser(UserModel.fromUser(user));

  @override
  Future<User> getCurrentUser() async {
    final fUser = await firebaseAuth.currentUser();
    return fUser != null ? userDataSource.getUser(fUser.uid) : fUser;
  }
}
