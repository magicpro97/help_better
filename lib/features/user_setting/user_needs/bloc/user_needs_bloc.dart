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
      updateUserNeeds(UserNeeds.TEENAGE);
    } else if (event is SelectOptionLoveEvent) {
      updateUserNeeds(UserNeeds.LOVE);
    } else if (event is SelectOptionFamilyEvent) {
      updateUserNeeds(UserNeeds.FAMILY);
    } else if (event is SelectOptionGoAheadEvent) {
      updateUserNeeds(UserNeeds.GO_AHEAD);
    } else if (event is JoinVolunteerEvent) {
	    addVolunteerType();
    }
    final result = backToLastScreen(event.context);
    if (!result) {
      goToMainScreen(event.context, deleteAllLastScreen: true);
    }
  }

  Future<void> updateUserNeeds(UserNeeds needs) async {
    final user = await Auth.currentUser();
    final data = {_key: userNeedMap[needs]};
    await UserDao.updateUser(id: user.id, fields: data);
  }

  Future<void> addVolunteerType() async {
	  final user = await Auth.currentUser();
	  user.types.add(UserType.VOLUNTEER);
	  await UserDao.updateUser(id: user.id, fields: user.toJson());
  }
}
