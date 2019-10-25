import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'base.dart';

part 'message_group.g.dart';

@JsonSerializable()
class MessageGroup extends Base {
  final String id;
  final String displayName;
  final String imageUrl;
  final DateTime created;
  final DateTime updated;

  MessageGroup({
    @required this.id,
    @required this.displayName,
    @required this.imageUrl,
    @required this.created,
    this.updated,
  })  : assert(displayName != null),
        assert(imageUrl != null),
        super(id, created, updated);

  factory MessageGroup.fromJson(Map<String, dynamic> json) =>
      _$MessageGroupFromJson(json);

  Map<String, dynamic> toJson() => _$MessageGroupToJson(this);
}
