import 'dart:async';
import 'dart:developer';

import 'package:better_help/common/route/route.dart';
import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/core/domain/usecase/get_current_user.dart';
import 'package:better_help/core/domain/usecase/get_user_stream.dart';
import 'package:better_help/core/domain/usecase/update_user.dart';
import 'package:better_help/features/user_setting/domain/usecases/sign_out.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

class UserSettingBloc extends Bloc<UserSettingEvent, UserSettingState> {
  final UpdateUser updateUser;
  final GetCurrentUser getCurrentUser;
  final SignOut signOut;
  final GetUserStream getUserStream;

  UserSettingBloc({
    @required this.getCurrentUser,
    @required this.updateUser,
    @required this.signOut,
    @required this.getUserStream,
  });

  @override
  UserSettingState get initialState => InitialUserSettingState();

  @override
  Stream<UserSettingState> mapEventToState(
    UserSettingEvent event,
  ) async* {
    log(event.toString());
    if (event is PressOnSignOutButton) {
      signOut();
      goToWelcomeScreen(event.context);
    } else if (event is PressOnChangeUserNeedsButton) {
      goToUserNeedsScreen(event.context);
    } else if (event is PressOnChangeNicknameButton) {
      goToNicknameScreen(event.context);
    } else if (event is SubmitNewNickname) {
      final currentUser = (await getCurrentUser());
      final newUser = currentUser.copyWith(
          updated: DateTime.now(), displayName: event.nickname);
      updateUser(newUser);

      final result = backToLastScreen(event.context);
      if (!result) {
        goToUserNeedsScreen(event.context);
      }
    } else if (event is PressOnNeedOption) {
      final currentUser = (await getCurrentUser());
      updateUser(currentUser.copyWith(
          updated: DateTime.now(), needs: event.userNeeds));

      final result = backToLastScreen(event.context);
      if (!result) {
        goToMainScreen(event.context);
      }
    } else if (event is PressOnJoinVolunteerButton) {
      final currentUser = (await getCurrentUser());
      updateUser(currentUser.copyWith(
          updated: DateTime.now(),
          types: currentUser.types..add(UserType.VOLUNTEER)));
      final result = backToLastScreen(event.context);
      if (!result) {
        goToMainScreen(event.context);
      }
    } else if (event is CheckUserType) {
      final currentUser = (await getCurrentUser());
      if (currentUser.types.contains(UserType.VOLUNTEER)) {
        yield AlreadyVolunteer();
      }
    } else if (event is InitCurrentUserStream) {
      final currentUser = await getCurrentUser();
      final userStream = getUserStream(currentUser.id);
      yield UserLoaded(userStream: userStream);
    }
  }
}
