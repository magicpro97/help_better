import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'base.dart';

part 'message_group.g.dart';

@JsonSerializable()
class MessageGroup extends Base {
    @JsonKey(nullable: false)
    final String id;
    final String displayName;
    final String imageUrl;
    @JsonKey(nullable: false)
    final List<String> memberIds;
    @JsonKey(nullable: false)
    final DateTime created;
    final DateTime updated;

    MessageGroup({
        @required this.id,
        this.displayName,
        this.imageUrl,
        @required this.memberIds,
        @required this.created,
        this.updated,
    })
        : assert(memberIds != null),
            assert(memberIds.length >= 2),
            super(id, created, updated);

    factory MessageGroup.fromJson(Map<String, dynamic> json) =>
        _$MessageGroupFromJson(json);

    Map<String, dynamic> toJson() => _$MessageGroupToJson(this);
}
