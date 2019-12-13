import 'dart:async';

import 'package:better_help/core/data/models/message_group_model.dart';
import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/features/message/presentation/widgets/message_group_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

final toMessageGroupList =
StreamTransformer<QuerySnapshot, List<MessageGroupModel>>.fromHandlers(
  handleData: (data, sink) =>
      sink.add(data.documents
          .map((doc) => MessageGroupModel.fromJson(doc.data))
          .toList()),
  handleError: (data, trace, sink) => sink.addError(data, trace),
);

StreamTransformer<List<MessageGroupModel>, List<MessageGroupCard>>
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
                            (user) => messageGroup.memberIds.contains(user.id))
                        .toList(),
              ))
              .toList()),
      handleError: (data, trace, sink) => sink.addError(data, trace),
    );

final toMessageGroup =
StreamTransformer<DocumentSnapshot, MessageGroupModel>.fromHandlers(
  handleData: (data, sink) => sink.add(MessageGroupModel.fromJson(data.data)),
  handleError: (data, trace, sink) => sink.addError(data, trace),
);
