import 'package:better_help/core/domain/entities/user.dart';

abstract class SessionRepository {
  Future<User> getCurrentUser();
}
