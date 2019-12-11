import 'package:better_help/core/domain/entities/message_group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'message_group_model.g.dart';

@JsonSerializable(anyMap: true)
class MessageGroupModel extends MessageGroup {
  MessageGroupModel({
    String id,
    String displayName,
    String imageUrl,
    @required List<String> memberIds,
    @required Map<String, MemberState> memberStatus,
    DateTime created,
    DateTime updated,
  }) : super(
      id: id ?? Uuid().v1(),
      displayName: displayName,
      imageUrl: imageUrl,
      memberIds: memberIds,
      memberStatus: memberStatus,
      created: created ?? DateTime.now(),
      updated: updated ?? DateTime.now());
  
  factory MessageGroupModel.fromJson(Map<String, dynamic> json) =>
      _$MessageGroupFromJson(json);
  
  Map<String, dynamic> toJson() => _$MessageGroupToJson(this);
  
  @override
  MessageGroup copyWith({String id,
    DateTime created,
    DateTime updated,
    String displayName,
    String imageUrl,
    List<String> memberIds,
    Map<String, MemberState> memberStatus}) {
    return MessageGroupModel(
      id: id ?? this.id,
      memberIds: memberIds ?? this.memberIds,
      memberStatus: memberStatus ?? this.memberStatus,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      displayName: displayName ?? this.displayName,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
