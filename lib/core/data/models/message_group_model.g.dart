// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageGroup _$MessageGroupFromJson(Map<String, dynamic> json) {
  return MessageGroupModel(
        id: json['id'] as String,
        displayName: json['displayName'] as String,
        imageUrl: json['imageUrl'] as String,
        memberIds: (json['memberIds'] as List)
            ?.map((e) => e as String)
            ?.toList(),
        memberStatus: (json['memberStatus'] as Map).map(
                (k, e) => MapEntry(k, _$enumDecode(_$MemberStateEnumMap, e)),
        ),
        created: (json['created'] as Timestamp).toDate(),
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
        'memberStatus': instance.memberStatus
            .map((k, e) => MapEntry(k, _$MemberStateEnumMap[e])),
        'created': instance.created.toUtc(),
        'updated': instance.updated?.toUtc(),
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues,
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

const _$MemberStateEnumMap = {
    MemberState.IN: 'IN',
    MemberState.OUT: 'OUT',
};
