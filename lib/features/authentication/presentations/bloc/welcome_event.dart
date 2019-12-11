import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();
}

class SignInEvent extends WelcomeEvent {
  final BuildContext context;

  SignInEvent(this.context);

  @override
  List<Object> get props => [context];
}

class CheckSignInStateEvent extends WelcomeEvent {
  final BuildContext context;

  CheckSignInStateEvent(this.context);

  @override
  List<Object> get props => [context];
}
