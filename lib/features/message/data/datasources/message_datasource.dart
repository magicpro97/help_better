import 'package:better_help/core/data/order_by.dart';
import 'package:better_help/core/data/tranformer/message.dart';
import 'package:better_help/features/message/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MessageDataSource {
  Stream<List<MessageModel>> messageListStream(
      {String messageGroupId, OrderBy orderBy});
}

class MessageDataSourceImpl implements MessageDataSource {
  final _messageGroupCollection =
      Firestore.instance.collection("message_groups");

  @override
  Stream<List<MessageModel>> messageListStream(
      {String messageGroupId, OrderBy orderBy}) {
    if (orderBy == null) {
      orderBy = OrderBy(field: 'created', desc: true);
    }

    return _messageGroupCollection
        .document(messageGroupId)
        .collection('messages')
        .orderBy(orderBy.field, descending: orderBy.desc)
        .snapshots()
        .transform(toMessageList);
  }
}
