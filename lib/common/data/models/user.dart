import 'package:better_help/common/data/models/base.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

final userNeedMapColor = {
    UserNeeds.TEENAGE: Colors.blue,
    UserNeeds.FAMILY: Colors.yellow[700],
    UserNeeds.LOVE: Colors.pink,
    UserNeeds.GO_AHEAD: Colors.greenAccent,
};

Map<UserNeeds, String> userNeedsOptionMapString(BuildContext context) => {
    UserNeeds.TEENAGE: S.of(context).option_family,
    UserNeeds.FAMILY: S.of(context).option_family,
    UserNeeds.LOVE: S.of(context).option_love,
    UserNeeds.GO_AHEAD: S.of(context).option_go_a_head,
};

String userNeedsDescription(BuildContext context, UserNeeds needs) =>
    S.of(context).need_help_description(
        userNeedsOptionMapString(context)[needs].toLowerCase());

@JsonSerializable()
class User extends Base {
    @JsonKey(nullable: false)
    final String id;
    @JsonKey(nullable: false)
    final String displayName;
    @JsonKey(nullable: false)
    final String email;
    final String phoneNumber;
    @JsonKey(nullable: false)
    final String photoUrl;
    @JsonKey(nullable: false)
    final List<UserType> types;
    final List<String> friendIds;
    final UserNeeds needs;
    @JsonKey(nullable: false)
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
        this.friendIds,
        @required this.created,
        this.updated,
    })  : assert(displayName != null),
            assert(email != null),
            assert(photoUrl != null),
            assert(types != null),
            assert(types.length > 0),
            super(id, created, updated);

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

    Map<String, dynamic> toJson() => _$UserToJson(this);
}
