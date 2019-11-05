import 'dart:async';
import 'dart:developer';

import 'package:better_help/common/auth0/auth.dart';
import 'package:better_help/common/data/dao/message_group_dao.dart';
import 'package:better_help/common/data/dao/user_dao.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/route/route.dart';
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
        log(event.toString());
        if (event is JoinVolunteerEvent) {
            final user = event.user;
            user.types.add(UserType.VOLUNTEER);
            UserDao.updateUser(id: event.user.id, fields: user.toJson());
        } else if (event is CreateMessageGroup) {
            final user = event.user;
            final currentUser = await Auth.currentUser();
            final members = [user, currentUser];
            final memberIds = members.map((mem) => mem.id).toList();
            var messageGroup = await MessageGroupDao.get(memberIds: memberIds);
            if (messageGroup == null) {
                addUniqueUser(user.friendIds, currentUser);
                addUniqueUser(currentUser.friendIds, user);
                await UserDao.updateUser(
                    id: currentUser.id, fields: currentUser.toJson());
                await UserDao.updateUser(id: user.id, fields: user.toJson());
                messageGroup = await MessageGroupDao.add(memberIds: memberIds);
            }
            goToMessageScreen(
                event.context,
                messageGroup,
                currentUser,
                event.otherUser
                    ..removeWhere((user) => !messageGroup.memberIds.contains(user.id)));
        }
    }

    void addUniqueUser(List<String> userIds, User user) {
        if (!user.friendIds.contains(user.id)) {
            user.friendIds.add(user.id);
        }
    }
}
