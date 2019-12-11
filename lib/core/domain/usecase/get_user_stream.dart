import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/core/domain/repositories/user_repository.dart';
import 'package:meta/meta.dart';

class GetUserStream {
  final UserRepository userRepository;

  GetUserStream({@required this.userRepository});

  Stream<User> call(String id) => userRepository.getStream(id);
}
