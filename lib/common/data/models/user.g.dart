// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    displayName: json['displayName'] as String,
    email: json['email'] as String,
    phoneNumber: json['phoneNumber'] as String,
    photoUrl: json['photoUrl'] as String,
    types: (json['types'] as List)
        ?.map((e) => _$enumDecodeNullable(_$UserTypeEnumMap, e))
        ?.toList(),
    needs: _$enumDecodeNullable(_$UserNeedsEnumMap, json['needs']),
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
    updated: json['updated'] == null
        ? null
        : DateTime.parse(json['updated'] as String),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'photoUrl': instance.photoUrl,
      'types': instance.types?.map((e) => _$UserTypeEnumMap[e])?.toList(),
      'needs': _$UserNeedsEnumMap[instance.needs],
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
