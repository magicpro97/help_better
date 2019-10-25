import 'package:equatable/equatable.dart';

abstract class UserNeedsState extends Equatable {
  const UserNeedsState();
}

class InitialUserNeedsState extends UserNeedsState {
  @override
  List<Object> get props => [];
}
