import 'package:better_help/core/domain/entities/message_group.dart';
import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/features/message/domain/entities/message.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();
}

class PressOnSendMessageButton extends MessageEvent {
  final String messageGroupId;
  final MessageType messageType;
  final String userId;
  final String content;
  
  PressOnSendMessageButton({@required this.content,
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

class GoOutEvent extends MessageEvent {
  final MessageGroup messageGroup;
  final User currentUser;
  
  GoOutEvent({@required this.messageGroup, @required this.currentUser});
  
  @override
  List<Object> get props => [messageGroup, currentUser];
}

class ComeInEvent extends MessageEvent {
  final MessageGroup messageGroup;
  final User currentUser;
  
  ComeInEvent({@required this.messageGroup, @required this.currentUser});
  
  @override
  List<Object> get props => [messageGroup, currentUser];
}
