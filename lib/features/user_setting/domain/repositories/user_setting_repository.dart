import 'package:better_help/features/user_setting/domain/entities/user.dart';

abstract class UserSettingRepository {
  Future<User> getUser(String id);

  Future<void> updateUser(User user);
}
