import 'package:better_help/common/data/models/message_group.dart';
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

  static Stream<MessageGroup> messageGroupStream({@required String groupId}) =>
      _store.document(groupId).snapshots().transform(toMessageGroup);
}
