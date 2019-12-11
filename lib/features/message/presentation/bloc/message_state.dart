import 'package:equatable/equatable.dart';

abstract class MessageState extends Equatable {
  const MessageState();
}

class InitialMessageGroupListState extends MessageState {
  @override
  List<Object> get props => [];
}
