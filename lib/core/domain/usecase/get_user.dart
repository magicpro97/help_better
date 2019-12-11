import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/core/domain/repositories/user_repository.dart';
import 'package:meta/meta.dart';

class GetUser {
  final UserRepository userRepository;

  GetUser({@required this.userRepository});

  Future<User> call(String id) => userRepository.get(id);
}
