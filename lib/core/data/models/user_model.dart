import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  UserModel(
      {String id,
      DateTime created,
      DateTime updated,
      @required String displayName,
      @required String email,
      String phoneNumber,
      @required String photoUrl,
      List<UserType> types = const [UserType.NORMAL],
      List<String> friendIds = const [],
      List<String> tokens = const [],
      UserNeeds needs,
        bool online = true})
      : super(
            id: id ?? Uuid().v1(),
            created: created ?? DateTime.now(),
            updated: updated ?? DateTime.now(),
            displayName: displayName,
            email: email,
            phoneNumber: phoneNumber,
            photoUrl: photoUrl,
            tokens: tokens,
            types: types,
            needs: needs,
            friendIds: friendIds,
            online: online);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromUser(User user) => UserModel(
        id: user.id,
        displayName: user.displayName,
        email: user.email,
        photoUrl: user.photoUrl,
        created: user.created,
        updated: user.updated,
        phoneNumber: user.phoneNumber,
        tokens: user.tokens,
        types: user.types,
        needs: user.needs,
        friendIds: user.friendIds,
        online: user.online,
      );

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  User copyWith({String id,
    DateTime created,
    DateTime updated,
    String displayName,
    String email,
    String phoneNumber,
    String photoUrl,
    List<UserType> types,
    List<String> friendIds,
    List<String> tokens,
    UserNeeds needs,
    bool online}) {
    return UserModel(
      id: id ?? this.id,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
      types: types ?? this.types,
      tokens: tokens ?? this.tokens,
      needs: needs ?? this.needs,
      online: online ?? this.online,
      friendIds: friendIds ?? this.friendIds,
    );
  }
}

Map<UserNeeds, String> userNeedsOptionMapString(BuildContext context) => {
      UserNeeds.TEENAGE: S.of(context).option_family,
      UserNeeds.FAMILY: S.of(context).option_family,
      UserNeeds.LOVE: S.of(context).option_love,
      UserNeeds.GO_AHEAD: S.of(context).option_go_a_head,
    };

String userNeedsDescription(BuildContext context, UserNeeds needs) =>
    S.of(context).need_help_description(
        userNeedsOptionMapString(context)[needs].toLowerCase());
