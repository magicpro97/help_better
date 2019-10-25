import 'dart:async';

import 'package:better_help/common/data/models/message_group.dart';
import 'package:better_help/features/message/message_group/group_card/message_group_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final toMessageGroupList =
    StreamTransformer<QuerySnapshot, List<MessageGroup>>.fromHandlers(
  handleData: (data, sink) => sink.add(
      data.documents.map((doc) => MessageGroup.fromJson(doc.data)).toList()),
    );

final toMessageGroupCardList =
StreamTransformer<List<MessageGroup>, List<MessageGroupCard>>.fromHandlers(
  handleData: (data, sink) =>
      sink.add(data
          .map((messageGroup) =>
          MessageGroupCard(
            messageGroupId: messageGroup.id,
          ))
          .toList()),
);

final toMessageGroup =
StreamTransformer<DocumentSnapshot, MessageGroup>.fromHandlers(
  handleData: (data, sink) => sink.add(MessageGroup.fromJson(data.data)),
);
