import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/core/domain/repositories/user_repository.dart';
import 'package:meta/meta.dart';

class UserOnline {
  final UserRepository userRepository;

  UserOnline({@required this.userRepository});

  Future<void> call(User user) =>
      userRepository.updateUser(user?.copyWith(online: true));
}