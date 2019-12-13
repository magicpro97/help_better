import 'package:better_help/core/data/models/message_group_model.dart';
import 'package:better_help/core/data/models/user_model.dart';
import 'package:better_help/core/data/tranformer/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserNeedsDataSource {
  Stream<List<UserModel>> userStream();

  Future<void> updateUser(UserModel user);

  Future<void> createMessageGroup(MessageGroupModel messageGroupModel);

  Future<MessageGroupModel> getMessageGroup(List<String> memberIds);
}

class UserNeedsDataSourceImpl implements UserNeedsDataSource {
  final _userCollection = Firestore.instance.collection('users');
  final _messageGroupCollection = Firestore.instance.collection(
      'message_groups');

  @override
  Stream<List<UserModel>> userStream() =>
      _userCollection.snapshots().transform(toUserList);

  @override
  Future<void> updateUser(UserModel user) =>
      _userCollection.document(user.id).updateData(user.toJson());

  @override
  Future<void> createMessageGroup(MessageGroupModel messageGroupModel) =>
      _userCollection
          .document(messageGroupModel.id)
          .setData(messageGroupModel.toJson());

  @override
  Future<MessageGroupModel> getMessageGroup(List<String> memberIds) async {
    final mGroups = (await _messageGroupCollection
        .where('memberIds', arrayContains: memberIds)
        .getDocuments())
        .documents
        .map((doc) => MessageGroupModel.fromJson(doc.data))
        .toList();
    if (mGroups.isNotEmpty) {
      return mGroups.first;
    } else {
      return null;
    }
  }
}
