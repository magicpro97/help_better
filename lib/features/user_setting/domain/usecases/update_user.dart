import 'package:better_help/core/usecase/usecase.dart';
import 'package:better_help/features/user_setting/domain/entities/user.dart';
import 'package:better_help/features/user_setting/domain/repositories/user_setting_repository.dart';

class UpdateUser implements UseCase<void, User> {
  final UserSettingRepository repository;

  UpdateUser(this.repository);

  @override
  Future<void> call(User user) => repository.updateUser(user);
}
