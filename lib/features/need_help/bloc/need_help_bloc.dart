import 'dart:async';

import 'package:better_help/common/data/dao/user_dao.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class NeedHelpBloc extends Bloc<NeedHelpEvent, NeedHelpState> {
  Stream<List<User>> get userListStream => UserDao.userListStream();

  @override
  NeedHelpState get initialState => InitialNeedHelpState();

  @override
  Stream<NeedHelpState> mapEventToState(
    NeedHelpEvent event,
  ) async* {
    if (event is JoinVolunteerEvent) {
      var user = event.user;
      user.types.add(UserType.VOLUNTEER);
      UserDao.updateUser(id: event.user.id, fields: user.toJson());
    }
  }
}
