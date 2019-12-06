import 'package:better_help/features/user_setting/data/user_setting_data_source.dart';
import 'package:better_help/features/user_setting/domain/entities/user.dart';
import 'package:better_help/features/user_setting/domain/repositories/user_setting_repository.dart';

class UserSettingRepositoryImpl implements UserSettingRepository {
  final UserSettingDataSource _dataSource;

  UserSettingRepositoryImpl(this._dataSource);

  @override
  Future<void> updateUser(User user) => _dataSource.updateUser(user);

  @override
  Future<User> getUser(String id) => _dataSource.getUser(id);
}
