import 'dart:async';

import 'package:better_help/common/data/dao/message_group_dao.dart';
import 'package:better_help/common/data/models/message_group.dart';
import 'package:better_help/features/app/bloc/app_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import './bloc.dart';

class MessageGroupBloc extends Bloc<MessageGroupEvent, MessageGroupState> {
  final AppBloc appBloc;

  final _messageGroupController = BehaviorSubject<List<MessageGroup>>();

  Stream<List<MessageGroup>> get listMessageGroupStream =>
      _messageGroupController.stream;

  MessageGroupBloc({@required this.appBloc}) : assert(appBloc != null);

  void initStream() {
    appBloc.userStream.listen((user) {
      if (user != null) {
        MessageGroupDao.messageGroupListStream(userId: user.id)
            .pipe(_messageGroupController);
      }
    });
  }

  @override
  void close() {
    _messageGroupController.close();
    super.close();
  }

  @override
  MessageGroupState get initialState => InitialMessageGroupState();

  @override
  Stream<MessageGroupState> mapEventToState(MessageGroupEvent event) async* {
  }
}
