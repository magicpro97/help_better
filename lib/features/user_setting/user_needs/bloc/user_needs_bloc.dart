import 'dart:async';

import 'package:better_help/common/auth0/auth.dart';
import 'package:better_help/common/data/dao/user_dao.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/route/route.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class UserNeedsBloc extends Bloc<UserNeedsEvent, UserNeedsState> {
  static final _key = 'needs';

  @override
  UserNeedsState get initialState => InitialUserNeedsState();

  @override
  Stream<UserNeedsState> mapEventToState(
    UserNeedsEvent event,
  ) async* {
    if (event is SelectOptionTeenageEvent) {
      await updateUserNeeds(UserNeeds.TEENAGE);
    } else if (event is SelectOptionLoveEvent) {
      await updateUserNeeds(UserNeeds.LOVE);
    } else if (event is SelectOptionFamilyEvent) {
      await updateUserNeeds(UserNeeds.FAMILY);
    } else if (event is SelectOptionGoAheadEvent) {
      await updateUserNeeds(UserNeeds.GO_AHEAD);
    }
    final result = backToLastScreen(event.context);
    if (!result) {
      goToMainScreen(event.context);
    }
  }

  Future updateUserNeeds(UserNeeds needs) async {
    final user = await Auth.currentUser();
    final data = {_key: userNeedMap[needs]};
    UserDao.updateUser(id: user.id, fields: data);
  }
}
