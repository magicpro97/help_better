import 'package:better_help/features/app/bloc/app_bloc.dart';
import 'package:better_help/features/user_setting/data/repositories/user_setting_repository_impl.dart';
import 'package:better_help/features/user_setting/data/user_setting_data_source.dart';
import 'package:better_help/features/user_setting/domain/repositories/user_setting_repository.dart';
import 'package:better_help/features/user_setting/domain/usecases/get_current_user.dart';
import 'package:better_help/features/user_setting/domain/usecases/update_user.dart';
import 'package:better_help/features/user_setting/presentations/bloc/bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  blocs();
  externals();
  userCases();
  repositories();
  dataSources();
}

void externals() {}

void dataSources() {
  sl.registerLazySingleton<UserSettingDataSource>(
          () => UserSettingDataSourceImpl());
}

void repositories() {
  sl.registerLazySingleton<UserSettingRepository>(
          () => UserSettingRepositoryImpl(dataSource: sl()));
}

void userCases() {
  sl.registerLazySingleton(() => GetCurrentUser(repository: sl()));
  sl.registerLazySingleton(() => UpdateUser(repository: sl()));
}

void blocs() {
  sl.registerFactory(() => AppBloc());
  sl.registerFactory(
    () => UserSettingBloc(
      updateUser: sl(),
      getCurrentUser: sl(),
    ),
  );
}
