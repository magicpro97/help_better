// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    id: json['id'] as String,
    userId: json['userId'] as String,
    content: json['content'] as String,
    type: _$enumDecodeNullable(_$MessageTypeEnumMap, json['type']),
    status: _$enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
    created: json['created'] == null
        ? null
        : (json['created'] as Timestamp).toDate(),
    updated: json['updated'] == null
        ? null
        : (json['updated'] as Timestamp).toDate(),
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'content': instance.content,
      'type': _$MessageTypeEnumMap[instance.type],
  'status': _$MessageStatusEnumMap[instance.status],
  'created': instance.created?.toUtc(),
  'updated': instance.updated?.toUtc(),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$MessageTypeEnumMap = {
  MessageType.TEXT: 'TEXT',
  MessageType.IMAGE: 'IMAGE',
  MessageType.STICKER: 'STICKER',
};

const _$MessageStatusEnumMap = {
  MessageStatus.SEND: 'SEND',
  MessageStatus.SENT: 'SENT',
  MessageStatus.READ: 'READ',
};
