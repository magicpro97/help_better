import 'package:better_help/common/data/models/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

enum UserType { NORMAL, VOLUNTEER }

enum UserNeeds { TEENAGE, FAMILY, LOVE, GO_AHEAD }

final userNeedMap = {
  UserNeeds.TEENAGE: 'TEENAGE',
  UserNeeds.FAMILY: 'FAMILY',
  UserNeeds.LOVE: 'LOVE',
  UserNeeds.GO_AHEAD: 'GO_AHEAD',
};

@JsonSerializable()
class User extends Base {
  final String id;
  final String displayName;
  final String email;
  final String phoneNumber;
  final String photoUrl;
  final List<UserType> types;
  final UserNeeds needs;
  final DateTime created;
  final DateTime updated;

  User({
    @required this.id,
    @required this.displayName,
    @required this.email,
    this.phoneNumber,
    @required this.photoUrl,
    @required this.types,
    this.needs,
    @required this.created,
    this.updated,
  })
      : assert(displayName != null),
        assert(email != null),
        assert(photoUrl != null),
        assert(types != null),
        assert(types.length > 0),
        super(id, created, updated);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
