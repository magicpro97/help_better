import 'package:better_help/core/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> get(String id);

  Stream<User> getStream(String id);

  Future<List<User>> getUserFriends(String userId);

  Future<void> updateUser(User user);

  Future<void> createUser(User user);

  Future<User> getCurrentUser();
}
