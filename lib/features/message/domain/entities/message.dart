import 'package:better_help/core/domain/entities/base.dart';

enum MessageType { TEXT, IMAGE, STICKER }

final messageTypeMap = {
  MessageType.TEXT: 'TEXT',
  MessageType.IMAGE: 'IMAGE',
  MessageType.STICKER: 'STICKER',
};

enum MessageStatus { SEND, SENT, SEEN, RECEIVED }

final messageStatusMap = {
  MessageStatus.SEND: 'SEND',
  MessageStatus.SENT: 'SENT',
  MessageStatus.SEEN: 'SEEN',
  MessageStatus.RECEIVED: 'RECEIVED',
};

abstract class Message extends Base {
  final String userId;
  final String content;
  final MessageType type;
  final Map<String, MessageStatus> status;

  Message({
    String id,
    this.userId,
    this.content,
    this.type,
    this.status,
    DateTime created,
    DateTime updated,
  }) : super(id: id, created: created, updated: updated);

  Message copyWith({
    String id,
    String userId,
    String content,
    MessageType type,
    final Map<String, MessageStatus> status,
    DateTime created,
    DateTime updated,
  });

  bool get hasReceiver => status.keys.length > 1;

  bool isReceivedMessage() {
    if (hasReceiver && status.values.contains(MessageStatus.RECEIVED)) {
      return true;
    }
    return false;
  }

  bool isSeenMessage() {
    if (hasReceiver && status.values.contains(MessageStatus.SEEN)) {
      return true;
    }
    return false;
  }

  bool isSentMessage() {
    if (status[userId] == MessageStatus.SENT) {
      return true;
    }
    return false;
  }
}
