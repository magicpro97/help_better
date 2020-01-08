import 'dart:developer';

import 'package:better_help/core/domain/entities/user.dart';    
import 'package:better_help/features/need_help/domain/repositories/user_needs_repository.dart';
import 'package:meta/meta.dart';

class MakeFriend {
  final UserNeedsRepository userNeedRepository;

  MakeFriend({@required this.userNeedRepository});

  Future<void> call(User currentUser, User needHelpUser) async {
    await userNeedRepository
        .updateUser(_addFriend(user: currentUser, other: needHelpUser));
    await userNeedRepository
        .updateUser(_addFriend(user: needHelpUser, other: currentUser));
  }

  User _addFriend({@required User user, @required User other}) {
    if (user.friendIds == null) {
      return user.copyWith(friendIds: [other.id]);
    } else {
      return user.copyWith(friendIds: user.friendIds..add(other.id));
    }
  }
}
