import 'package:better_help/core/domain/entities/message_group.dart';
import 'package:better_help/core/domain/entities/user.dart';

abstract class UserNeedsRepository {
  Stream<List<User>> userStream();

  Future<void> updateUser(User user);

  MessageGroup createMessageGroup(String currentUserId, List<String> memberIds,
      Map<String, MemberState> memberStatus);

  Future<MessageGroup> getMessageGroup(List<String> memberIds);
}