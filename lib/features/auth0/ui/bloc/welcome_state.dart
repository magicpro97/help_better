import 'package:equatable/equatable.dart';

abstract class WelcomeState extends Equatable {
  const WelcomeState();
}

class CheckSignInState extends WelcomeState {
  @override
  List<Object> get props => [];
}

class NewUserState extends WelcomeState {
  @override
  List<Object> get props => null;
}

class SignInFailState extends WelcomeState {
  @override
  List<Object> get props => null;
}

class SignedState extends WelcomeState {
  @override
  List<Object> get props => null;
}
