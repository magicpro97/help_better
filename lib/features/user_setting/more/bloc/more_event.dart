import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class MoreEvent extends Equatable {
  const MoreEvent();
}

class SignOutEvent extends MoreEvent {
  final BuildContext context;

  SignOutEvent(this.context);

  @override
  List<Object> get props => null;
}

class ChangeUserNeedsEvent extends MoreEvent {
  final BuildContext context;

  ChangeUserNeedsEvent(this.context);

  @override
  List<Object> get props => null;
}

class ChangeNicknameEvent extends MoreEvent {
  final BuildContext context;

  ChangeNicknameEvent(this.context);

  @override
  List<Object> get props => null;
}
