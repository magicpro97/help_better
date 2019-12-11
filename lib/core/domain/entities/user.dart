import 'package:better_help/core/domain/entities/base.dart';
import 'package:meta/meta.dart';

enum UserType { NORMAL, VOLUNTEER }

enum UserNeeds { TEENAGE, FAMILY, LOVE, GO_AHEAD }

abstract class User extends Base {
  final String displayName;
  final String email;
  final String phoneNumber;
  final String photoUrl;
  final List<UserType> types;
  final List<String> friendIds;
  final List<String> tokens;
  final UserNeeds needs;
  final bool online;

  User(
      {@required String id,
      @required DateTime created,
      @required DateTime updated,
      @required this.displayName,
      @required this.email,
      this.phoneNumber,
      @required this.photoUrl,
      @required this.types,
      @required this.friendIds,
      @required this.tokens,
      this.needs,
      @required this.online})
      : super(id: id, created: created, updated: updated);

  User copyWith({
    String id,
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
    bool online,
  });
}
