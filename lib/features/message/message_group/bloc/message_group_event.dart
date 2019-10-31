import 'package:better_help/common/data/models/message.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class MessageGroupEvent extends Equatable {
  const MessageGroupEvent();
}

class AddMessageEvent extends MessageGroupEvent {
  final String messageGroupId;
  final MessageType messageType;
  final String userId;
  final String content;

  AddMessageEvent({@required this.content,
    @required this.userId,
    @required this.messageType,
    @required this.messageGroupId})
      : assert(content != null),
        assert(userId != null),
        assert(messageGroupId != null),
        assert(messageType != null);

  @override
  List<Object> get props => [content, userId, messageType, messageGroupId];
}
