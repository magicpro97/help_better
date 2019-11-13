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
            .map((e) => _$enumDecode(_$UserTypeEnumMap, e))
            .toList(),
        needs: _$enumDecodeNullable(_$UserNeedsEnumMap, json['needs']),
        friendIds: (json['friendIds'] as List)
            ?.map((e) => e as String)
            ?.toList(),
        tokens: (json['tokens'] as List)?.map((e) => e as String)?.toList(),
        online: json['online'] as bool,
        created: json['created'] == null
            ? null
            : json['created'] is DateTime
            ? json['created']
            : (json['created'] as Timestamp).toDate(),
        updated: json['updated'] == null
            ? null
            : json['updated'] is DateTime
            ? json['updated']
            : (json['updated'] as Timestamp).toDate(),
    );
}

Map<String, dynamic> _$UserToJson(User instance) =>
    <String, dynamic>{
        'id': instance.id,
        'displayName': instance.displayName,
        'email': instance.email,
        'phoneNumber': instance.phoneNumber,
        'photoUrl': instance.photoUrl,
        'types': instance.types.map((e) => _$UserTypeEnumMap[e]).toList(),
        'friendIds': instance.friendIds,
        'tokens': instance.tokens,
        'online': instance.online,
        'created': instance.created?.toUtc(),
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

const _$UserTypeEnumMap = {
    UserType.NORMAL: 'NORMAL',
    UserType.VOLUNTEER: 'VOLUNTEER',
};

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues,
    dynamic source, {
        T unknownValue,
    }) {
    if (source == null) {
        return null;
    }
    return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$UserNeedsEnumMap = {
    UserNeeds.TEENAGE: 'TEENAGE',
    UserNeeds.FAMILY: 'FAMILY',
    UserNeeds.LOVE: 'LOVE',
    UserNeeds.GO_AHEAD: 'GO_AHEAD',
};
