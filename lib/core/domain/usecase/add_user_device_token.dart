import 'package:better_help/core/domain/repositories/session_repository.dart';
import 'package:better_help/core/domain/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class AddUserDeviceToken {
  final SessionRepository sessionRepository;
  final UserRepository userRepository;

  AddUserDeviceToken(
      {@required this.userRepository, @required this.sessionRepository});

  Future<void> call(String token) async {
    FirebaseAuth.instance.onAuthStateChanged.listen((fUser) async {
      final user = await sessionRepository.getCurrentUser();
      if (fUser != null) {
        if (user.tokens == null) {
          userRepository.updateUser(user.copyWith(tokens: [token]));
        } else if (!user.tokens.contains(token)) {
          user.tokens.add(token);
          userRepository.updateUser(user);
        }
      }
    });
  }
}
