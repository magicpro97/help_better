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
            UserDao.updateUser(user: user);
        } else if (event is CreateMessageGroup) {
            final user = event.user;
            final currentUser = await Auth.currentUser();
            final members = [user, currentUser];
            final memberIds = members.map((mem) => mem.id).toList();
            var messageGroup = await MessageGroupDao.get(memberIds: memberIds);
            if (messageGroup == null) {
                await addUniqueUser(user, currentUser.id);
                await addUniqueUser(currentUser, user.id);
                messageGroup = await MessageGroupDao.add(currentUserId: currentUser.id, memberIds: memberIds);
            }
            if (!event.otherUser.map((user) => user.id).contains(user.id)) {
                final newUser = await UserDao.findById(user.id);
                event.otherUser.add(newUser);
            }
            goToMessageScreen(
                event.context,
                messageGroup,
                currentUser,
                event.otherUser
                    ..removeWhere((user) =>
                    !messageGroup.memberIds.contains(user.id)));
        }
    }

    Future<void> addUniqueUser(User user, String id) async {
        final json = user.toJson();
        if (user.friendIds == null) {
            json['friendIds'] = [id];
            await UserDao.updateUser(user: User.fromJson(json));
        } else {
            if (!user.friendIds.contains(id)) {
                user.friendIds.add(id);
            }
            await UserDao.updateUser(user: user);
        }
    }
}
