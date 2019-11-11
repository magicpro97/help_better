import 'package:better_help/common/data/models/message.dart';
import 'package:better_help/common/data/models/message_group.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
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

class GoOutEvent extends MessageGroupEvent {
    final MessageGroup messageGroup;
    final User currentUser;
    
    GoOutEvent({@required this.messageGroup, @required this.currentUser});
    
    @override
    List<Object> get props => [messageGroup, currentUser];
}

class ComeInEvent extends MessageGroupEvent {
    final MessageGroup messageGroup;
    final User currentUser;
    
    ComeInEvent({@required this.messageGroup, @required this.currentUser});
    
    @override
    List<Object> get props => [messageGroup, currentUser];
}
