// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberStatus _$MemberStatusFromJson(Map<dynamic, dynamic> json) {
    return MemberStatus(
        id: json['id'] as String,
        state: _$enumDecode(_$MemberStateEnumMap, json['state']),
    );
}

Map<String, dynamic> _$MemberStatusToJson(MemberStatus instance) =>
    <String, dynamic>{
        'id': instance.id,
        'state': _$MemberStateEnumMap[instance.state],
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

MessageGroup _$MessageGroupFromJson(Map<String, dynamic> json) {
  return MessageGroup(
    id: json['id'] as String,
    displayName: json['displayName'] as String,
    imageUrl: json['imageUrl'] as String,
      memberStatus: (json['memberStatus'] as List)
          .map((e) => MemberStatus.fromJson(e as Map))
          .toList(),
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
        'memberStatus': instance.memberStatus.map((e) => e.toJson()).toList(),
        'created': instance.created.toUtc(),
      'updated': instance.updated?.toUtc(),
    };
