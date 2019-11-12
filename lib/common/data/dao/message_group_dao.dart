import 'package:better_help/common/data/dao/user_dao.dart';
import 'package:better_help/common/data/models/message_group.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/data/order_by.dart';
import 'package:better_help/common/data/tranformer/message_group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class MessageGroupDao {
    static final _collection = 'message_groups';
    static final _store = Firestore.instance.collection(_collection);

    static Stream<List<MessageGroup>> listStream(
        {@required String userId, OrderBy orderBy}) =>
        _store
            .where('memberIds', arrayContains: userId)
            .orderBy(orderBy.field, descending: orderBy.desc)
            .snapshots()
            .transform(toMessageGroupList);

    static Stream<MessageGroup> stream({@required String messageGroupId}) =>
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

    static Future<MessageGroup> add(
        {@required List<String> memberIds,
            @required String currentUserId}) async {
        final memberStatus = <String, MemberState>{};
        memberStatus[currentUserId] = MemberState.IN;
        memberIds.where((id) => id != currentUserId).forEach((id) => memberStatus[id] = MemberState.OUT);
        final newMessageGroup = MessageGroup(
            id: Uuid().v1(),
            memberStatus: memberStatus,
            memberIds: memberIds,
            created: DateTime.now());
        await _store.document(newMessageGroup.id).setData(newMessageGroup.toJson());
        return newMessageGroup;
    }

    static Future<List<MessageGroup>> getList({@required String userId}) async {
        final qSnapshot =
        await _store.where('memberIds', arrayContains: userId).getDocuments();
        return qSnapshot.documents
            .map((doc) => MessageGroup.fromJson(doc.data))
            .toList();
    }

    static Future<MessageGroup> get({@required List<String> memberIds}) async {
        final docs =
            (await _store.where('memberIds', isEqualTo: memberIds).getDocuments())
                .documents;
        if (docs.length > 0) {
            return MessageGroup.fromJson(docs.first.data);
        } else {
            return null;
        }
    }

    static Future<void> update({@required MessageGroup messageGroup}) =>
        _store.document(messageGroup.id).updateData(messageGroup.toJson());
}
