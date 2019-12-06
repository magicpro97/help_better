import 'package:equatable/equatable.dart';

abstract class UserSettingState extends Equatable {
  const UserSettingState();
}

class InitialUserSettingState extends UserSettingState {
  @override
  List<Object> get props => [];
}

class AlreadyVolunteer extends UserSettingState {
  @override
  List<Object> get props => [];
}
