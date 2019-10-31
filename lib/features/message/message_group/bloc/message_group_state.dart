import 'package:equatable/equatable.dart';

abstract class MessageGroupState extends Equatable {
  const MessageGroupState();
}

class InitialMessageGroupState extends MessageGroupState {
  @override
  List<Object> get props => [];
}
