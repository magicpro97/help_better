import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/core/domain/repositories/session_repository.dart';
import 'package:meta/meta.dart';

class GetCurrentUser {
  final SessionRepository sessionRepository;

  GetCurrentUser({@required this.sessionRepository});

  Future<User> call() => sessionRepository.getCurrentUser();
}
