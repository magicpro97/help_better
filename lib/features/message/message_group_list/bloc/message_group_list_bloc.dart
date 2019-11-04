import 'dart:async';

import 'package:better_help/common/data/dao/message_group_dao.dart';
import 'package:better_help/common/data/models/message_group.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

class MessageGroupListBloc
    extends Bloc<MessageGroupListEvent, MessageGroupListState> {
  Stream<List<MessageGroup>> listMessageGroupList({
    @required String userId,
  }) =>
      MessageGroupDao.messageGroupListStream(userId: userId);

  @override
  MessageGroupListState get initialState => InitialMessageGroupListState();

  @override
  Stream<MessageGroupListState> mapEventToState(
    MessageGroupListEvent event,
  ) async* {}
}
