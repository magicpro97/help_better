import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'base.dart';

part 'message_group.g.dart';

enum MemberState {
    IN,
    OUT,
}

@JsonSerializable(anyMap: true)
class MemberStatus {
    @JsonKey(nullable: false)
    final String id;
    @JsonKey(nullable: false)
    final MemberState state;

    MemberStatus({@required this.id, @required this.state})
        : assert(id != null),
            assert(state != null);

    factory MemberStatus.fromJson(Map<dynamic, dynamic> json) =>
        _$MemberStatusFromJson(json);

    Map<String, dynamic> toJson() => _$MemberStatusToJson(this);
}

@JsonSerializable()
class MessageGroup extends Base {
    @JsonKey(nullable: false)
    final String id;
    final String displayName;
    final String imageUrl;
    @JsonKey(nullable: false)
    final List<MemberStatus> memberStatus;
    @JsonKey(nullable: false)
    final DateTime created;
    final DateTime updated;

    MessageGroup({
        @required this.id,
        this.displayName,
        this.imageUrl,
        @required this.memberStatus,
        @required this.created,
        this.updated,
    })
        : assert(memberStatus != null),
            assert(memberStatus.length >= 2),
            super(id, created, updated);

    factory MessageGroup.fromJson(Map<String, dynamic> json) =>
        _$MessageGroupFromJson(json);

    Map<String, dynamic> toJson() => _$MessageGroupToJson(this);
}
