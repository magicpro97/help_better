import 'package:better_help/core/domain/entities/user.dart';

abstract class AuthenticationRepository {
  Future<User> getCurrentUser();

  Future<User> getUser(String id);

  Future<void> createUser(User user);
}
