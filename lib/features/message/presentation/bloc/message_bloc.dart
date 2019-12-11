import 'dart:async';

import 'package:better_help/core/domain/entities/message_group.dart';
import 'package:better_help/features/message/domain/entities/message.dart';
import 'package:better_help/features/message/domain/usecases/get_message_group_list_stream.dart';
import 'package:better_help/features/message/domain/usecases/get_message_list_stream.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'bloc.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final GetMessageListStream getMessageListStream;
  final GetMessageGroupStream getMessageGroupStream;
  
  MessageBloc({@required this.getMessageListStream,
    @required this.getMessageGroupStream});
  
  Stream<List<MessageGroup>> listMessageGroupList({@required String userId}) =>
      getMessageGroupStream(userId);
  
  Stream<List<Message>> messageListStream(String messageGroupId) =>
      getMessageListStream(messageGroupId);
  
  @override
  MessageState get initialState => InitialMessageGroupListState();
  
  @override
  Stream<MessageState> mapEventToState(MessageEvent event,) async* {}
}
