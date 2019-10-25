import 'package:better_help/common/data/models/message_group.dart';
import 'package:better_help/common/data/tranformer/message_group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageGroupDao {
  static final _collection = 'message_groups';
  static final _store = Firestore.instance.collection(_collection);

  static Stream<List<MessageGroup>> messageGroupListStream({int limit = 20}) =>
      _store.limit(limit).snapshots().transform(toMessageGroupList);

  static Stream<MessageGroup> messageGroupStream(String groupId) =>
      _store.document(groupId).snapshots().transform(toMessageGroup);
}
