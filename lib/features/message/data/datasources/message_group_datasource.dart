import 'package:better_help/core/data/models/message_group_model.dart';
import 'package:better_help/core/data/order_by.dart';
import 'package:better_help/core/data/tranformer/message_group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MessageGroupDataSource {
  Stream<List<MessageGroupModel>> messageGroupListStream(
      {String userId, OrderBy orderBy});
}

class MessageGroupDataSourceImpl extends MessageGroupDataSource {
  final _messageGroupCollection =
      Firestore.instance.collection('message_groups');

  @override
  Stream<List<MessageGroupModel>> messageGroupListStream(
      {String userId, OrderBy orderBy}) {
    if (orderBy == null) {
      orderBy = OrderBy(field: 'created', desc: true);
    }
    return _messageGroupCollection
        .where('memberIds', arrayContains: userId)
        .orderBy(orderBy.field, descending: orderBy.desc)
        .snapshots()
        .transform(toMessageGroupList);
  }
}
