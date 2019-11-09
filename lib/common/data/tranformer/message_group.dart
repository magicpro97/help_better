import 'dart:async';

import 'package:better_help/common/data/models/message_group.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/features/message/message_group_list/message_group_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

final toMessageGroupList =
    StreamTransformer<QuerySnapshot, List<MessageGroup>>.fromHandlers(
  handleData: (data, sink) => sink.add(
      data.documents.map((doc) => MessageGroup.fromJson(doc.data)).toList()),
        handleError: (data, trace, sink) => sink.addError(data, trace),
    );

StreamTransformer<List<MessageGroup>, List<MessageGroupCard>>
toMessageGroupCardList(
    {@required User currentUser, @required List<User> friends}) =>
    StreamTransformer.fromHandlers(
        handleData: (data, sink) =>
            sink.add(data
                .map((messageGroup) =>
                MessageGroupCard(
                    messageGroup: messageGroup,
                    currentUser: currentUser,
                    otherUser: friends
                        .where(
                            (user) =>
                            messageGroup.memberStatus.map((mem) => mem.id)
                                .contains(user.id))
                        .toList(),
                ))
                .toList()),
        handleError: (data, trace, sink) => sink.addError(data, trace),
    );

final toMessageGroup =
StreamTransformer<DocumentSnapshot, MessageGroup>.fromHandlers(
  handleData: (data, sink) => sink.add(MessageGroup.fromJson(data.data)),
  handleError: (data, trace, sink) => sink.addError(data, trace),
);
