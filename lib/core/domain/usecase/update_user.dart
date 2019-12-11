import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/core/domain/repositories/user_repository.dart';
import 'package:meta/meta.dart';

class UpdateUser {
  final UserRepository userSettingRepository;

  UpdateUser({@required this.userSettingRepository});

  Future<void> call(User user) => userSettingRepository.updateUser(user);
}
