import 'package:better_help/common/data/models/base.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'message.g.dart';

enum MessageType { TEXT, IMAGE, STICKER }

final messageTypeMap = {
  MessageType.TEXT: 'TEXT',
  MessageType.IMAGE: 'IMAGE',
  MessageType.STICKER: 'STICKER',
};

@JsonSerializable()
class Message extends Base {
  final String id;
  final String userId;
  final String content;
  final MessageType type;
  final DateTime created;
  final DateTime updated;

  Message(
      {@required this.id,
      @required this.userId,
      @required this.content,
      @required this.type,
      @required this.created,
      this.updated})
      : assert(userId != null),
        assert(content != null),
        assert(type != null),
        super(id, created, updated);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
