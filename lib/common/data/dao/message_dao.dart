import 'package:better_help/common/data/models/message.dart';
import 'package:better_help/common/data/order_by.dart';
import 'package:better_help/common/data/tranformer/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class MessageDao {
    static final _collection = 'message_groups';
    static final _subCollection = 'messages';
    static final _store = Firestore.instance.collection(_collection);
    
    static Stream<List<Message>> listStream(String groupId, {
        @required OrderBy orderBy,
    }) =>
        _store
            .document(groupId)
            .collection(_subCollection)
            .orderBy(orderBy.field, descending: orderBy.desc)
            .snapshots()
            .transform(toMessageList);
    
    static Stream<Message> message(String groupId, String messageId) =>
        _store
            .document(groupId)
            .collection(_subCollection)
            .document(messageId)
            .snapshots()
            .transform(toMessage);
    
    static Future<void> add({
        @required String groupId,
        @required Message message,
    }) async =>
        await _store
            .document(groupId)
            .collection(_subCollection)
            .document(message.id)
            .setData(message.toJson());
}
