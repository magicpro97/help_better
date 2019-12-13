import 'package:better_help/core/data/data_sources/firebase_auth_source.dart';
import 'package:better_help/core/data/repositories/session_repository_impl.dart';
import 'package:better_help/core/data/repositories/user_repository_impl.dart';
import 'package:better_help/core/domain/repositories/user_repository.dart';
import 'package:better_help/core/domain/usecase/add_user_device_token.dart';
import 'package:better_help/core/domain/usecase/get_user_friend.dart';
import 'package:better_help/core/domain/usecase/get_user_stream.dart';
import 'package:better_help/core/domain/usecase/user_offline.dart';
import 'package:better_help/core/domain/usecase/user_online.dart';
import 'package:better_help/features/authentication/domain/use_cases/sign_in.dart';
import 'package:better_help/features/authentication/presentations/bloc/welcome_bloc.dart';
import 'package:better_help/features/message/data/repositories/message_group_repository_impl.dart';
import 'package:better_help/features/message/data/repositories/message_repository_impl.dart';
import 'package:better_help/features/message/domain/repositories/message_group_repository.dart';
import 'package:better_help/features/message/domain/repositories/message_repository.dart';
import 'package:better_help/features/message/domain/usecases/get_message_group_list_stream.dart';
import 'package:better_help/features/message/domain/usecases/get_message_list_stream.dart';
import 'package:better_help/features/message/presentation/bloc/bloc.dart';
import 'package:better_help/features/need_help/domain/repositories/user_needs_repository.dart';
import 'package:better_help/features/need_help/domain/usecases/create_message_group.dart';
import 'package:better_help/features/need_help/domain/usecases/get_message_group.dart';
import 'package:better_help/features/need_help/domain/usecases/get_user_list_stream.dart';
import 'package:better_help/features/need_help/domain/usecases/join_volunteer.dart';
import 'package:better_help/features/need_help/domain/usecases/make_friend.dart';
import 'package:better_help/features/user_setting/domain/usecases/sign_out.dart';
import 'package:better_help/features/user_setting/presentations/bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'core/data/data_sources/user_data_source.dart';
import 'core/domain/repositories/session_repository.dart';
import 'core/domain/usecase/create_user.dart';
import 'core/domain/usecase/get_current_user.dart';
import 'core/domain/usecase/get_user.dart';
import 'core/domain/usecase/update_user.dart';
import 'features/app/presentations/bloc/app_bloc.dart';
import 'features/main/presentation/bloc/main_bloc.dart';
import 'features/message/data/datasources/message_datasource.dart';
import 'features/message/data/datasources/message_group_datasource.dart';
import 'features/need_help/data/repositories/user_needs_repository_impl.dart';
import 'features/need_help/data/user_needs_data_source.dart';
import 'features/need_help/presentation/bloc/need_help_bloc.dart';

final sl = GetIt.instance;

void init() {
  blocs();
  externals();
  userCases();
  repositories();
  dataSources();
}

void externals() {
  sl.registerLazySingleton(() =>
      GoogleSignIn(
        scopes: ['email'],
      ));
  sl.registerLazySingleton(() => FirebaseMessaging());
}

void dataSources() {
  sl.registerLazySingleton(() => FirebaseAuthSource());

  sl.registerLazySingleton<UserDataSource>(() => UserDataSourceImpl());
  sl.registerLazySingleton<MessageGroupDataSource>(
          () => MessageGroupDataSourceImpl());
  sl.registerLazySingleton<MessageDataSource>(() => MessageDataSourceImpl());
  sl.registerLazySingleton<UserNeedsDataSource>(
          () => UserNeedsDataSourceImpl());
}

void repositories() {
  sl.registerLazySingleton<SessionRepository>(
          () => SessionRepositoryImpl(firebaseAuthSource: sl()));

  sl.registerLazySingleton<UserRepository>(
          () => UserRepositoryImpl(userDataSource: sl()));
  sl.registerLazySingleton<MessageGroupRepository>(
          () => MessageGroupRepositoryImpl(messageGroupDataSource: sl()));
  sl.registerLazySingleton<MessageRepository>(
          () => MessageRepositoryImpl(messageDataSource: sl()));
  sl.registerLazySingleton<UserNeedsRepository>(
          () => UserNeedsRepositoryImpl(userNeedDataSource: sl()));
}

void userCases() {
  sl.registerLazySingleton(() => GetCurrentUser(sessionRepository: sl()));
  sl.registerLazySingleton(() => CreateUser(userRepository: sl()));
  sl.registerLazySingleton(() => UpdateUser(userSettingRepository: sl()));
  sl.registerLazySingleton(
          () => SignIn(googleSignIn: sl(), userRepository: sl()));
  sl.registerLazySingleton(() => SignOut(googleSignIn: sl()));
  sl.registerLazySingleton(() => GetUserStream(userRepository: sl()));
  sl.registerLazySingleton(() => GetUserFriends(userRepository: sl()));
  sl.registerLazySingleton(
          () => GetMessageGroupStream(messageGroupRepository: sl()));
  sl.registerLazySingleton(() => GetMessageListStream(messageRepository: sl()));
  sl.registerLazySingleton(() => GetUserListStream(userNeedRepository: sl()));
  sl.registerLazySingleton(() => MakeFriend(userNeedRepository: sl()));
  sl.registerLazySingleton(() => GetUser(userRepository: sl()));
  sl.registerLazySingleton(() => GetMessageGroup(userNeedRepository: sl()));
  sl.registerLazySingleton(() => JoinVolunteer(userNeedRepository: sl()));
  sl.registerLazySingleton(() => CreateMessageGroup(userNeedRepository: sl()));
  sl.registerLazySingleton(() => UserOffline(userRepository: sl()));
  sl.registerLazySingleton(() => UserOnline(userRepository: sl()));
  sl.registerLazySingleton(
          () =>
          AddUserDeviceToken(userRepository: sl(), sessionRepository: sl()));
}

void blocs() {
  sl.registerFactory(
        () =>
        AppBloc(
          getCurrentUser: sl(),
          userOnline: sl(),
          userOffline: sl(),
          firebaseMessaging: sl(),
        ),
  );
  sl.registerFactory(
    () => UserSettingBloc(
      updateUser: sl(),
      getCurrentUser: sl(),
      signOut: sl(),
    ),
  );
  sl.registerFactory(
        () =>
        WelcomeBloc(
          createUser: sl(),
          signIn: sl(),
          getCurrentUser: sl(),
          addUserDeviceToken: sl(),
          firebaseMessaging: sl(),
        ),
  );
  sl.registerFactory(
        () =>
        MainBloc(
          signIn: sl(),
          getCurrentUser: sl(),
          getUserFriends: sl(),
          getUserStream: sl(),
        ),
  );
  sl.registerFactory(
        () =>
        MessageBloc(
          getMessageGroupStream: sl(),
          getMessageListStream: sl(),
        ),
  );
  sl.registerFactory(
        () =>
        NeedHelpBloc(
          getUserListStream: sl(),
          makeFriend: sl(),
          getCurrentUser: sl(),
          getUser: sl(),
          getMessageGroup: sl(),
          joinVolunteer: sl(),
          createMessageGroup: sl(),
        ),
  );
}
