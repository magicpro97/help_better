import 'package:better_help/core/domain/entities/message_group.dart';
import 'package:better_help/features/need_help/domain/repositories/user_needs_repository.dart';
import 'package:meta/meta.dart';

class GetMessageGroup {
  final UserNeedsRepository userNeedRepository;

  GetMessageGroup({@required this.userNeedRepository});

  Future<MessageGroup> call(List<String> memberIds) =>
      userNeedRepository.getMessageGroup(memberIds);
}
