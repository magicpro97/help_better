import 'dart:async';
import 'dart:developer';

import 'package:better_help/core/domain/entities/message_group.dart';
import 'package:better_help/features/message/data/models/message_model.dart';
import 'package:better_help/features/message/domain/entities/message.dart';
import 'package:better_help/features/message/domain/usecases/create_message.dart';
import 'package:better_help/features/message/domain/usecases/get_message_group_list_stream.dart';
import 'package:better_help/features/need_help/domain/usecases/update_message_group.dart';
import 'package:better_help/features/message/domain/usecases/get_message_list_stream.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import 'bloc.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final GetMessageListStream getMessageListStream;
  final GetMessageGroupStream getMessageGroupStream;
  final CreateMessage createMessage;
  final UpdateMessageGroup updateMessageGroup;
  
  MessageBloc({@required this.getMessageListStream,
    @required this.getMessageGroupStream,
    @required this.createMessage,
    @required this.updateMessageGroup});
  
  Stream<List<MessageGroup>> listMessageGroupList({@required String userId}) =>
      getMessageGroupStream(userId);
  
  Stream<List<Message>> messageListStream(String messageGroupId) =>
      getMessageListStream(messageGroupId);
  
  @override
  MessageState get initialState => InitialMessageGroupListState();
  
  @override
  Stream<MessageState> mapEventToState(MessageEvent event,) async* {
    if (event is PressOnSendMessageButton) {
      final newMessage = MessageModel(
          id: Uuid().v1(),
          userId: event.userId,
          content: event.content,
          type: event.messageType,
          status: {event.userId: MessageStatus.SEND},
          created: DateTime.now());
      //log(event.messageGroupId, name: 'groupID');
      createMessage(event.messageGroupId, newMessage);
    } else if (event is GoOutEvent) {
        event.messageGroup.memberStatus[event.currentUser.id] =
            MemberState.OUT;
        updateMessageGroup(event.messageGroup);
    } else if (event is ComeInEvent) {
        event.messageGroup.memberStatus[event.currentUser.id] =
            MemberState.IN;
        updateMessageGroup(event.messageGroup);
    }
  }
} 
