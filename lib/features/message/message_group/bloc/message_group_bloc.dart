import 'dart:async';

import 'package:better_help/common/data/dao/message_dao.dart';
import 'package:better_help/common/data/dao/message_group_dao.dart';
import 'package:better_help/common/data/models/message.dart';
import 'package:better_help/common/data/models/message_group.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import './bloc.dart';

class MessageGroupBloc extends Bloc<MessageGroupEvent, MessageGroupState> {
  Stream<MessageGroup> messageGroupStream({@required String messageGroupId}) =>
      MessageGroupDao.messageGroupStream(messageGroupId: messageGroupId);

  Stream<List<Message>> messageListStream({@required String messageGroupId}) =>
      MessageDao.messageListStream(messageGroupId, desc: true);

  @override
  MessageGroupState get initialState => InitialMessageGroupState();

  @override
  Stream<MessageGroupState> mapEventToState(MessageGroupEvent event,) async* {
    if (event is AddMessageEvent) {
      final newMessage = Message(
          id: Uuid().v1(),
          userId: event.userId,
          content: event.content,
          type: event.messageType,
          created: DateTime.now());
      MessageDao.addMessage(groupId: event.messageGroupId, message: newMessage);
    }
  }
}
