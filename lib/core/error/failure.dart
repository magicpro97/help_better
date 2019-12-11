import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class SignInFailure implements Failure {
  @override
  List<Object> get props => [];
}

class SignOutFailure implements Failure {
  @override
  List<Object> get props => [];
}
