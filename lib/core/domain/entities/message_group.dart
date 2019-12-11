import 'package:better_help/core/domain/entities/base.dart';

enum MemberState {
  IN,
  OUT,
}

abstract class MessageGroup extends Base {
  final String displayName;
  final String imageUrl;
  final List<String> memberIds;
  final Map<String, MemberState> memberStatus;

  MessageGroup(
      {String id,
      DateTime created,
      DateTime updated,
      this.displayName,
      this.imageUrl,
      this.memberIds,
      this.memberStatus})
      : super(id: id, updated: updated, created: created);

  MessageGroup copyWith(
      {String id,
      DateTime created,
      DateTime updated,
      String displayName,
      String imageUrl,
      List<String> memberIds,
      Map<String, MemberState> memberStatus});
}
