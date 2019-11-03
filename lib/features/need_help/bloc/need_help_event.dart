import 'package:better_help/common/data/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class NeedHelpEvent extends Equatable {
  const NeedHelpEvent();
}

class JoinVolunteerEvent extends NeedHelpEvent {
  final User user;

  JoinVolunteerEvent({@required this.user});

  @override
  List<Object> get props => [user];
}
