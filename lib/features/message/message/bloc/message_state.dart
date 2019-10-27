import 'package:equatable/equatable.dart';

abstract class MessageState extends Equatable {
  const MessageState();
}

class InitialMessageState extends MessageState {
  @override
  List<Object> get props => [];
}
