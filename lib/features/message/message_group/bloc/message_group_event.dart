import 'package:equatable/equatable.dart';

abstract class MessageGroupEvent extends Equatable {
  const MessageGroupEvent();
}

class GetMessageGroupList extends MessageGroupEvent {
  @override
  List<Object> get props => null;
}
