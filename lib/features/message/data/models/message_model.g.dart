// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map json) {
  return MessageModel(
    id: json['id'] as String,
    userId: json['userId'] as String,
    content: json['content'] as String,
    type: _$enumDecode(_$MessageTypeEnumMap, json['type']),
      status: (json['status'] as Map).map(
              (k, e) =>
              MapEntry(k as String, _$enumDecode(_$MessageStatusEnumMap, e)),
      ),
      created: (json['created'] as Timestamp).toDate(),
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
    'status':
    instance.status.map((k, e) => MapEntry(k, _$MessageStatusEnumMap[e])),
    'created': instance.created.toUtc(),
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

const _$MessageTypeEnumMap = {
  MessageType.TEXT: 'TEXT',
  MessageType.IMAGE: 'IMAGE',
  MessageType.STICKER: 'STICKER',
};

const _$MessageStatusEnumMap = {
  MessageStatus.SEND: 'SEND',
  MessageStatus.SENT: 'SENT',
  MessageStatus.SEEN: 'SEEN',
  MessageStatus.RECEIVED: 'RECEIVED',
};
