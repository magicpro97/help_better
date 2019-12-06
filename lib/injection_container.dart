import 'package:better_help/features/app/bloc/app_bloc.dart';
import 'package:better_help/features/user_setting/data/repositories/user_setting_repository_impl.dart';
import 'package:better_help/features/user_setting/data/user_setting_data_source.dart';
import 'package:better_help/features/user_setting/domain/repositories/user_setting_repository.dart';
import 'package:better_help/features/user_setting/domain/usecases/get_current_user.dart';
import 'package:better_help/features/user_setting/domain/usecases/update_user.dart';
import 'package:better_help/features/user_setting/presentations/bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  blocs();
  userCases();
  repositories();
  dataSources();
  externals();
}

void externals() {
  sl.registerLazySingleton(() => Firestore.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
}

void dataSources() {
  sl.registerLazySingleton<UserSettingDataSource>(
    () => UserSettingDataSourceImpl(
      sl(),
    ),
  );
}

void repositories() {
  sl.registerLazySingleton<UserSettingRepository>(
    () => UserSettingRepositoryImpl(
      sl(),
    ),
  );
}

void userCases() {
  sl.registerLazySingleton(
    () => GetCurrentUser(
      firebaseAuth: sl(),
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => UpdateUser(
      sl(),
    ),
  );
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
