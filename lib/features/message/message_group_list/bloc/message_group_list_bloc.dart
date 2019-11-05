import 'dart:async';

import 'package:better_help/common/data/dao/message_group_dao.dart';
import 'package:better_help/common/data/models/message_group.dart';
import 'package:better_help/common/data/order_by.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

class MessageGroupListBloc
    extends Bloc<MessageGroupListEvent, MessageGroupListState> {
    Stream<List<MessageGroup>> listMessageGroupList(
        {@required String userId, OrderBy orderBy}) =>
        MessageGroupDao.listStream(userId: userId, orderBy: orderBy);

    @override
    MessageGroupListState get initialState => InitialMessageGroupListState();

    @override
    Stream<MessageGroupListState> mapEventToState(
        MessageGroupListEvent event,
        ) async* {}
}
