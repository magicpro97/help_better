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
    memberIds: (json['memberIds'] as List)?.map((e) => e as String)?.toList(),
    created: json['created'] == null
        ? null
        : (json['created'] as Timestamp).toDate(),
    updated: json['updated'] == null
        ? null
        : (json['updated'] as Timestamp).toDate(),
  );
}

Map<String, dynamic> _$MessageGroupToJson(MessageGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'imageUrl': instance.imageUrl,
      'memberIds': instance.memberIds,
      'created': instance.created?.toUtc(),
      'updated': instance.updated?.toUtc(),
    };
