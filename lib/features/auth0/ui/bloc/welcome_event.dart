import 'package:equatable/equatable.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();
}

class SignInEvent extends WelcomeEvent {
  @override
  List<Object> get props => null;

}

class CheckSignInStateEvent extends WelcomeEvent {
  @override
  List<Object> get props => null;
}