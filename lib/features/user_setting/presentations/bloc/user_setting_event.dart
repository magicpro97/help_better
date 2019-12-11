import 'package:better_help/core/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class UserSettingEvent extends Equatable {
  const UserSettingEvent();
}

class PressOnSignOutButton extends UserSettingEvent {
  final BuildContext context;

  PressOnSignOutButton({@required this.context});

  @override
  List<Object> get props => [];
}

class PressOnChangeUserNeedsButton extends UserSettingEvent {
  final BuildContext context;

  PressOnChangeUserNeedsButton({@required this.context});

  @override
  List<Object> get props => [];
}

class PressOnChangeNicknameButton extends UserSettingEvent {
  final BuildContext context;

  PressOnChangeNicknameButton({@required this.context});

  @override
  List<Object> get props => [];
}

class SubmitNewNickname extends UserSettingEvent {
  final BuildContext context;
  final String nickname;

  SubmitNewNickname({@required this.context, @required this.nickname});

  @override
  List<Object> get props => [nickname];
}

class PressOnNeedOption extends UserSettingEvent {
  final BuildContext context;
  final UserNeeds userNeeds;

  PressOnNeedOption({@required this.context, @required this.userNeeds});

  @override
  List<Object> get props => [userNeeds];
}

class PressOnJoinVolunteerButton extends UserSettingEvent {
  final BuildContext context;

  PressOnJoinVolunteerButton({@required this.context});

  @override
  List<Object> get props => [];
}

class CheckUserType extends UserSettingEvent {
  @override
  List<Object> get props => [];
}

class ReloadCurrentUser extends UserSettingEvent {
  @override
  List<Object> get props => [];
}
