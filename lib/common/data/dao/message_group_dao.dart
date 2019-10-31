import 'package:better_help/common/data/dao/user_dao.dart';
import 'package:better_help/common/data/models/message_group.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/data/tranformer/message_group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class MessageGroupDao {
  static final _collection = 'message_groups';
  static final _store = Firestore.instance.collection(_collection);

  static Stream<List<MessageGroup>> messageGroupListStream(
      {@required String userId, int limit = 20}) =>
      _store
          .limit(limit)
          .where('memberIds', arrayContains: userId)
          .snapshots()
          .transform(toMessageGroupList);

  static Stream<MessageGroup> messageGroupStream(
      {@required String messageGroupId}) =>
      _store.document(messageGroupId).snapshots().transform(toMessageGroup);

  static Future<List<User>> getOtherUser(
      {@required String groupId, @required String currentUserId}) async {
    final List<User> users = [];
    final doc = await _store.document(groupId).get();
    final messageGroup = MessageGroup.fromJson(doc.data);
    for (String id in messageGroup.memberIds) {
      if (id != currentUserId) {
        users.add(await UserDao.findById(id));
      }
    }
    return users;
  }
}
