import 'dart:async';
import 'dart:developer';

import 'package:better_help/common/auth0/auth.dart';
import 'package:better_help/common/route/route.dart';
import 'package:better_help/core/usecase/usecase.dart';
import 'package:better_help/features/user_setting/domain/entities/user.dart';
import 'package:better_help/features/user_setting/domain/usecases/get_current_user.dart';
import 'package:better_help/features/user_setting/domain/usecases/update_user.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

class UserSettingBloc extends Bloc<UserSettingEvent, UserSettingState> {
  final UpdateUser updateUser;
  final GetCurrentUser getCurrentUser;

  UserSettingBloc({
    @required this.getCurrentUser,
    @required this.updateUser,
  });

  @override
  UserSettingState get initialState => InitialUserSettingState();

  @override
  Stream<UserSettingState> mapEventToState(
    UserSettingEvent event,
  ) async* {
    log(event.toString());
    if (event is SignOut) {
      Auth.signOut();
      goToWelcomeScreen(event.context);
    } else if (event is PressOnChangeUserNeedsButton) {
      goToUserNeedsScreen(event.context);
    } else if (event is PressOnChangeNicknameButton) {
      goToNicknameScreen(event.context);
    } else if (event is SubmitNewNickname) {
      final user = (await getCurrentUser(NoParams()))
          .copyWith(updated: DateTime.now(), displayName: event.nickname);
      updateUser(user);

      final result = backToLastScreen(event.context);
      if (!result) {
        goToUserNeedsScreen(event.context);
      }
    } else if (event is PressOnNeedOption) {
      final user = (await getCurrentUser(NoParams()))
          .copyWith(updated: DateTime.now(), needs: event.userNeeds);
      updateUser(user);

      log('aaa');
      final result = backToLastScreen(event.context);
      log('bbb');
      if (!result) {
        goToMainScreen(event.context);
      }
    } else if (event is JoinVolunteer) {
      final user = (await getCurrentUser(NoParams()));
      final newUser = user.copyWith(
          updated: DateTime.now(), types: user.types..add(UserType.VOLUNTEER));
      updateUser(newUser);

      final result = backToLastScreen(event.context);
      if (!result) {
        goToMainScreen(event.context);
      }
    }
  }
}
