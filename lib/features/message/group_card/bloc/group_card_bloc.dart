import 'dart:async';

import 'package:better_help/common/data/dao/message_dao.dart';
import 'package:better_help/common/data/dao/message_group_dao.dart';
import 'package:better_help/common/data/models/message.dart';
import 'package:better_help/common/data/models/message_group.dart';
import 'package:better_help/common/data/tranformer/message.dart';
import 'package:better_help/common/route/route.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class GroupCardBloc extends Bloc<GroupCardEvent, GroupCardState> {
  final _messageGroupController = BehaviorSubject<MessageGroup>();
  final _latestMessageController = BehaviorSubject<Message>();

  Stream<MessageGroup> get messageGroupStream => _messageGroupController.stream;

  MessageGroup get messageGroup => _messageGroupController.value;

  Stream<Message> get latestGroupStream => _latestMessageController.stream;

  void initStream(String groupId) {
    MessageGroupDao.messageGroupStream(groupId).pipe(_messageGroupController);

    MessageDao.messageList(groupId)
        .transform(toLatestMessage)
        .pipe(_latestMessageController);
  }

  @override
  void close() {
    super.close();
    _messageGroupController.close();
    _latestMessageController.close();
  }

  @override
  GroupCardState get initialState => InitialGroupCardState();

  @override
  Stream<GroupCardState> mapEventToState(
    GroupCardEvent event,) async* {
    if (event is MakeChattingEvent) {
      goToMessageScreen(event.context, messageGroup.id);
    }
  }
}
