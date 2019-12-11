import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/features/authentication/data/data_sources/authencation_data_source.dart';
import 'package:better_help/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDataSource dataSource;

  AuthenticationRepositoryImpl({@required this.dataSource});

  @override
  Future<User> getCurrentUser() async {
    final fUser = await FirebaseAuth.instance.currentUser();

    return await dataSource.getUser(fUser.uid);
  }

  @override
  Future<User> getUser(String id) => dataSource.getUser(id);

  @override
  Future<void> createUser(User user) => dataSource.createUser(user);
}
