import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/core/domain/repositories/user_repository.dart';

class GetUserFriends {
  final UserRepository userRepository;

  GetUserFriends({this.userRepository});

  Future<List<User>> call(String userId) =>
      userRepository.getUserFriends(userId);
}
