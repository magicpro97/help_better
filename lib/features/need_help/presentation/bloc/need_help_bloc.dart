import 'dart:async';

import 'package:better_help/common/route/route.dart';
import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/core/domain/usecase/get_current_user.dart';
import 'package:better_help/core/domain/usecase/get_user.dart';
import 'package:better_help/features/need_help/domain/usecases/create_message_group.dart';
import 'package:better_help/features/need_help/domain/usecases/get_message_group.dart';
import 'package:better_help/features/need_help/domain/usecases/get_user_list_stream.dart';
import 'package:better_help/features/need_help/domain/usecases/join_volunteer.dart';
import 'package:better_help/features/need_help/domain/usecases/make_friend.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

class NeedHelpBloc extends Bloc<NeedHelpEvent, NeedHelpState> {
  final GetCurrentUser getCurrentUser;
  final GetUserListStream getUserListStream;
  final JoinVolunteer joinVolunteer;
  final MakeFriend makeFriend;
  final CreateMessageGroup createMessageGroup;
  final GetMessageGroup getMessageGroup;
  final GetUser getUser;

  NeedHelpBloc(
      {@required this.getCurrentUser,
      @required this.getUserListStream,
      @required this.joinVolunteer,
      @required this.makeFriend,
      @required this.createMessageGroup,
      @required this.getMessageGroup,
      @required this.getUser});

  Stream<List<User>> get userListStream => getUserListStream();

  @override
  NeedHelpState get initialState => InitialNeedHelpState();

  @override
  Stream<NeedHelpState> mapEventToState(
    NeedHelpEvent event,
  ) async* {
    //log(event.toString());
    if (event is JoinVolunteerEvent) {
      joinVolunteer(await getCurrentUser());
    } else if (event is PressOnUserItem) {
      final needHelpUser = event.user;
      final currentUser = await getCurrentUser();
      final members = [event.user, currentUser];
      final memberIds = members.map((mem) => mem.id).toList();
      var messageGroup = await getMessageGroup(memberIds);
      if (messageGroup == null) {
        await makeFriend(needHelpUser, currentUser);
        await makeFriend(currentUser, needHelpUser);
        messageGroup = createMessageGroup(currentUser.id, memberIds);
      }
      if (!event.otherUser.map((user) => user.id).contains(needHelpUser.id)) {
        final newUser = await getUser(needHelpUser.id);
        event.otherUser.add(newUser);
      }
      goToMessageScreen(
          event.context,
          messageGroup,
          currentUser,
          event.otherUser
            ..removeWhere((user) => !messageGroup.memberIds.contains(user.id)));
    }
  }
}
