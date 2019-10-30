import 'dart:async';

import 'package:better_help/common/data/dao/message_dao.dart';
import 'package:better_help/common/data/dao/message_group_dao.dart';
import 'package:better_help/common/data/models/message.dart';
import 'package:better_help/common/data/models/message_group.dart';
import 'package:better_help/features/app/bloc/app_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import './bloc.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final AppBloc appBloc;
  final _messageGroupController = BehaviorSubject<MessageGroup>();
  final _messageListController = BehaviorSubject<List<Message>>();

  MessageBloc({@required this.appBloc}) : assert(appBloc != null);

  Stream<MessageGroup> get messageGroupStream => _messageGroupController.stream;

  Stream<List<Message>> get messageListStream => _messageListController.stream;

  void initStream(String groupId) {
    MessageGroupDao.messageGroupStream(groupId: groupId)
        .pipe(_messageGroupController);

    MessageDao.messageList(groupId).pipe(_messageListController);
  }

  @override
  void close() {
    super.close();
    _messageGroupController
        .drain()
        .then((data) => _messageGroupController.close());
    _messageListController
        .drain()
        .then((data) => _messageListController.close());
  }

  @override
  MessageState get initialState => InitialMessageState();

  @override
  Stream<MessageState> mapEventToState(MessageEvent event,) async* {}
}
