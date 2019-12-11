import 'package:better_help/core/data/data_sources/user_data_source.dart';
import 'package:better_help/core/data/models/user_model.dart';
import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/core/domain/repositories/user_repository.dart';
import 'package:meta/meta.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl({@required this.userDataSource});

  @override
  Future<User> get(String id) => userDataSource.getUser(id);

  @override
  Stream<User> getStream(String id) => userDataSource.getUserStream(id);

  @override
  Future<List<User>> getUserFriends(String id) =>
      userDataSource.getUserFriends(id);

  @override
  Future<void> updateUser(User user) =>
      userDataSource.update(UserModel.fromUser(user));
}
