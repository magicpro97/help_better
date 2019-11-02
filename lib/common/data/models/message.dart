import 'package:better_help/common/data/models/base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'message.g.dart';

enum MessageType { TEXT, IMAGE, STICKER }

final messageTypeMap = {
  MessageType.TEXT: 'TEXT',
  MessageType.IMAGE: 'IMAGE',
  MessageType.STICKER: 'STICKER',
};

enum MessageStatus { SEND, SENT, READ }

final messageStatusMap = {
  MessageStatus.SEND: 'SEND',
  MessageStatus.SENT: 'SENT',
  MessageStatus.READ: 'READ',
};

@JsonSerializable()
class Message extends Base {
  final String id;
  final String userId;
  final String content;
  final MessageType type;
  final MessageStatus status;
  final DateTime created;
  final DateTime updated;

  Message({
    @required this.id,
    @required this.userId,
    @required this.content,
    @required this.type,
    @required this.status,
    @required this.created,
    this.updated,
  })
      : assert(userId != null),
        assert(content != null),
        assert(type != null),
        assert(status != null),
        super(id, created, updated);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
