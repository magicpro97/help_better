import 'package:better_help/common/data/models/message_group.dart';
import 'package:better_help/common/data/tranformer/message_group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageGroupDao {
  static final _store = Firestore.instance.collection('message_groups');

  static Stream<List<MessageGroup>> messageGroupStream({int limit = 20}) =>
      _store.limit(limit).snapshots().transform(toMessageGroupList);
}
