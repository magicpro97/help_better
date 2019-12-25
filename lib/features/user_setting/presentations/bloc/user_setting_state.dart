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
  final Stream<User> userStream;
  
  UserLoaded({@required this.userStream});
  
  @override
  List<Object> get props => [];
}
