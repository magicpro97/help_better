import 'package:better_help/features/user_setting/data/models/user_model.dart';
import 'package:better_help/features/user_setting/data/user_setting_data_source.dart';
import 'package:better_help/features/user_setting/domain/entities/user.dart';
import 'package:better_help/features/user_setting/domain/repositories/user_setting_repository.dart';
import 'package:meta/meta.dart';

class UserSettingRepositoryImpl implements UserSettingRepository {
  final UserSettingDataSource dataSource;

  UserSettingRepositoryImpl({@required this.dataSource});

  @override
  Future<void> updateUser(User user) => dataSource.updateUser(UserModel.fromUser(user));

  @override
  Future<User> getUser(String id) => dataSource.getUser(id);
}
