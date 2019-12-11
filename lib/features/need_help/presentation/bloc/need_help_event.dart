import 'package:better_help/core/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
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

class PressOnUserItem extends NeedHelpEvent {
  final BuildContext context;
  final User user;
  final List<User> otherUser;

  PressOnUserItem({
    @required this.user,
    @required this.context,
    @required this.otherUser,
  });

  @override
  List<Object> get props => [user, context];
}
