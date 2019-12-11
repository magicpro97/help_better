import 'package:better_help/features/message/domain/entities/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'message_model.g.dart';

@JsonSerializable(anyMap: true)
class MessageModel extends Message {
  MessageModel({
    String id,
    @required String userId,
    @required String content,
    @required MessageType type,
    @required Map<String, MessageStatus> status,
    DateTime created,
    DateTime updated,
  })  : assert(userId != null),
        assert(content != null),
        assert(type != null),
        assert(status != null),
        super(
            id: id ?? Uuid().v1,
            created: created ?? DateTime.now(),
            updated: updated ?? DateTime.now(),
            userId: userId,
            content: content,
            type: type,
            status: status);

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @override
  Message copyWith(
      {String id,
      String userId,
      String content,
      MessageType type,
      Map<String, MessageStatus> status,
      DateTime created,
      DateTime updated}) {
    return MessageModel(
      userId: userId ?? this.userId,
      content: content ?? this.content,
      type: type ?? this.type,
      status: status ?? this.status,
      id: id ?? this.id,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }
}
