// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageGroup _$MessageGroupFromJson(Map<String, dynamic> json) {
  return MessageGroup(
    id: json['id'] as String,
    displayName: json['displayName'] as String,
    imageUrl: json['imageUrl'] as String,
    memberIds: (json['memberIds'] as List).map((e) => e as String).toList(),
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
    updated: json['updated'] == null
        ? null
        : DateTime.parse(json['updated'] as String),
  );
}

Map<String, dynamic> _$MessageGroupToJson(MessageGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'imageUrl': instance.imageUrl,
      'memberIds': instance.memberIds,
      'created': instance.created?.toIso8601String(),
      'updated': instance.updated?.toIso8601String(),
    };
