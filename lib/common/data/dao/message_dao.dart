import 'package:better_help/common/data/models/message.dart';
import 'package:better_help/common/data/tranformer/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageDao {
  static final _collection = 'message_groups';
  static final _subCollection = 'messages';
  static final _store = Firestore.instance.collection(_collection);

  static Stream<List<Message>> messageList(String groupId) => _store
      .document(groupId)
      .collection(_subCollection)
      .snapshots()
      .transform(toMessageList);
}
