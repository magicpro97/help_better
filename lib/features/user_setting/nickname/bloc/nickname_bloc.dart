import 'dart:async';

import 'package:better_help/common/auth0/auth.dart';
import 'package:better_help/common/data/dao/user_dao.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/route/route.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class NicknameBloc extends Bloc<NicknameEvent, NicknameState> {
    @override
    NicknameState get initialState => InitialNicknameState();
    
    @override
    Stream<NicknameState> mapEventToState(NicknameEvent event,) async* {
        if (event is SaveNewNickname) {
            final user = await Auth.currentUser();
            final json = user.toJson();
            json['displayName'] = event.nickname;
            UserDao.updateUser(user: User.fromJson(json));
            final result = backToLastScreen(event.context);
            if (!result) {
                goToUserNeedsScreen(event.context, deleteAllLastScreen: true);
            }
        }
    }
}
