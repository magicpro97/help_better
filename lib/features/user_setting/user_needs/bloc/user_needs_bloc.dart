import 'dart:async';
import 'dart:developer';

import 'package:better_help/common/auth0/auth.dart';
import 'package:better_help/common/data/dao/user_dao.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/route/route.dart';
import 'package:better_help/features/main/main_screen.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class UserNeedsBloc extends Bloc<UserNeedsEvent, UserNeedsState> {
    static final _key = 'needs';
    
    @override
    UserNeedsState get initialState => InitialUserNeedsState();
    
    @override
    Stream<UserNeedsState> mapEventToState(UserNeedsEvent event,) async* {
        log(event.toString());
        if (event is SelectOptionTeenageEvent) {
            await updateUserNeeds(UserNeeds.TEENAGE);
        } else if (event is SelectOptionLoveEvent) {
            await updateUserNeeds(UserNeeds.LOVE);
        } else if (event is SelectOptionFamilyEvent) {
            await updateUserNeeds(UserNeeds.FAMILY);
        } else if (event is SelectOptionGoAheadEvent) {
            await updateUserNeeds(UserNeeds.GO_AHEAD);
        } else if (event is JoinVolunteerEvent) {
            await addVolunteerType();
        }
        final result = backToLastScreen(event.context);
        if (!result) {
            final user = await Auth.currentUser();
            goToMainScreen(event.context, deleteAllLastScreen: true,
                arguments: MainArgument(user: user));
        }
    }
    
    Future<void> updateUserNeeds(UserNeeds needs) async {
        final user = await Auth.currentUser();
        final json = user.toJson();
        json[_key] = userNeedMap[needs];
        await UserDao.updateUser(user: User.fromJson(json));
    }
    
    Future<void> addVolunteerType() async {
        final user = await Auth.currentUser();
        user.types.add(UserType.VOLUNTEER);
        await UserDao.updateUser(user: user);
    }
}
