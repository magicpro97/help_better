import 'package:better_help/core/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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

class UserLoaded extends UserSettingState {
  final User user;
  
  UserLoaded({@required this.user});
  
  @override
  List<Object> get props => [];
}
