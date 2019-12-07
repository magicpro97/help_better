import 'package:better_help/core/usecase/usecase.dart';
import 'package:better_help/features/user_setting/domain/entities/user.dart';
import 'package:better_help/features/user_setting/domain/repositories/user_setting_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class GetCurrentUser implements UseCase<User, NoParams> {
  final UserSettingRepository repository;

  GetCurrentUser({@required this.repository});

  @override
  Future<User> call(NoParams param) async {
    final fUser = await FirebaseAuth.instance.currentUser();
    return repository.getUser(fUser.uid);
  }
}
