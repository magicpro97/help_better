import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/features/need_help/domain/repositories/user_needs_repository.dart';
import 'package:meta/meta.dart';

class JoinVolunteer {
  final UserNeedsRepository userNeedRepository;

  JoinVolunteer({@required this.userNeedRepository});

  void call(User user) => userNeedRepository
      .updateUser(user.copyWith(types: user.types..add(UserType.VOLUNTEER)));
}
