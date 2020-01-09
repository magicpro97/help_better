import 'package:better_help/core/domain/entities/message_group.dart';
import 'package:better_help/features/need_help/domain/repositories/user_needs_repository.dart';
import 'package:meta/meta.dart';

class CreateMessageGroup {
  final UserNeedsRepository userNeedRepository;

  CreateMessageGroup({@required this.userNeedRepository});

  Future<MessageGroup> call(String currentUserId, List<String> memberIds) {
    final memberStatus = Map<String, MemberState>();
    memberStatus[currentUserId] = MemberState.IN;
    memberIds
        .where((id) => id != currentUserId)
        .forEach((id) => memberStatus[id] = MemberState.IN);
    return userNeedRepository.createMessageGroup(
        currentUserId, memberIds, memberStatus);
  }
}
