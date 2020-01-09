import 'dart:developer';

import 'package:better_help/core/data/models/message_group_model.dart';
import 'package:better_help/core/data/models/user_model.dart';
import 'package:better_help/core/domain/entities/message_group.dart';
import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/features/need_help/data/user_needs_data_source.dart';
import 'package:better_help/features/need_help/domain/repositories/user_needs_repository.dart';
import 'package:meta/meta.dart';

class UserNeedsRepositoryImpl implements UserNeedsRepository {
  final UserNeedsDataSource userNeedDataSource;

  UserNeedsRepositoryImpl({@required this.userNeedDataSource});

  @override
  Stream<List<User>> userStream() => userNeedDataSource.userStream();

  @override
  Future<void> updateUser(User user) =>
      userNeedDataSource.updateUser(UserModel.fromUser(user));

  @override
  Future<MessageGroup> createMessageGroup(String currentUserId, List<String> memberIds,
      Map<String, MemberState> memberStatus) async{
    final messageGroup = MessageGroupModel(
      memberIds: memberIds,
      memberStatus: memberStatus,
    );
    await userNeedDataSource.createMessageGroup(messageGroup);

    return messageGroup;
  }

  @override
  Future<void> updateMessageGroup(MessageGroupModel messageGroup) => userNeedDataSource.updateMessageGroup(messageGroup);

  @override
  Future<MessageGroup> getMessageGroup(List<String> memberIds) =>
      userNeedDataSource.getMessageGroup(memberIds);
}
