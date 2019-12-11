import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/features/need_help/domain/repositories/user_needs_repository.dart';
import 'package:meta/meta.dart';

class GetUserListStream {
  final UserNeedsRepository userNeedRepository;

  GetUserListStream({@required this.userNeedRepository});

  Stream<List<User>> call() => userNeedRepository.userStream();
}
