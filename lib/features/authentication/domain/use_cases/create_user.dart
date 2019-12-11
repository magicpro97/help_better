import 'package:better_help/core/data/models/user_model.dart';
import 'package:better_help/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class CreateUser {
  final AuthenticationRepository repository;

  CreateUser({@required this.repository});

  Future<void> call() async {
    final fUser = await FirebaseAuth.instance.currentUser();
    repository.createUser(UserModel(
      photoUrl: fUser.photoUrl,
      displayName: fUser.displayName,
      email: fUser.email,
    ));
  }
}
