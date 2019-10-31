import 'package:equatable/equatable.dart';

abstract class MessageGroupListState extends Equatable {
  const MessageGroupListState();
}

class InitialMessageGroupListState extends MessageGroupListState {
  @override
  List<Object> get props => [];
}
