// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] as String,
    created: json['created'] == null
        ? null
        : (json['created'] as Timestamp).toDate(),
    updated: json['updated'] == null
        ? null
        : (json['updated'] as Timestamp).toDate(),
    displayName: json['displayName'] as String,
    email: json['email'] as String,
    phoneNumber: json['phoneNumber'] as String,
    photoUrl: json['photoUrl'] as String,
    types: (json['types'] as List)
        ?.map((e) => _$enumDecodeNullable(_$UserTypeEnumMap, e))
        ?.toList(),
    friendIds: (json['friendIds'] as List)?.map((e) => e as String)?.toList(),
    tokens: (json['tokens'] as List)?.map((e) => e as String)?.toList(),
    needs: _$enumDecodeNullable(_$UserNeedsEnumMap, json['needs']),
    online: json['online'] as bool,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'created': instance.created?.toUtc(),
      'updated': instance.updated?.toUtc(),
      'displayName': instance.displayName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'photoUrl': instance.photoUrl,
      'types': instance.types?.map((e) => _$UserTypeEnumMap[e])?.toList(),
      'friendIds': instance.friendIds,
      'tokens': instance.tokens,
      'needs': _$UserNeedsEnumMap[instance.needs],
      'online': instance.online,
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

const _$UserTypeEnumMap = {
  UserType.NORMAL: 'NORMAL',
  UserType.VOLUNTEER: 'VOLUNTEER',
};

const _$UserNeedsEnumMap = {
  UserNeeds.TEENAGE: 'TEENAGE',
  UserNeeds.FAMILY: 'FAMILY',
  UserNeeds.LOVE: 'LOVE',
  UserNeeds.GO_AHEAD: 'GO_AHEAD',
};
