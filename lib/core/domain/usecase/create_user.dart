import 'package:better_help/core/data/models/user_model.dart';
import 'package:better_help/core/domain/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class CreateUser {
  final UserRepository userRepository;
  
  CreateUser({@required this.userRepository});

  Future<void> call() async {
    final fUser = await FirebaseAuth.instance.currentUser();
    userRepository.createUser(UserModel(
      photoUrl: fUser.photoUrl,
      displayName: fUser.displayName,
      email: fUser.email,
    ));
  }
}
