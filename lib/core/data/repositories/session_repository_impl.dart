import 'package:better_help/core/data/data_sources/firebase_auth_source.dart';
import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/core/domain/repositories/session_repository.dart';
import 'package:meta/meta.dart';

class SessionRepositoryImpl implements SessionRepository {
  final FirebaseAuthSource firebaseAuthSource;

  SessionRepositoryImpl({@required this.firebaseAuthSource});

  @override
  Future<User> getCurrentUser() => firebaseAuthSource.getCurrentUser();
}
