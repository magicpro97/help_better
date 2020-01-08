import 'package:better_help/core/data/models/message_group_model.dart';
import 'package:better_help/features/need_help/domain/repositories/user_needs_repository.dart';
import 'package:meta/meta.dart';

class UpdateMessageGroup {
  final UserNeedsRepository userNeedRepository;

  UpdateMessageGroup({@required this.userNeedRepository});

  Future<void> call(MessageGroupModel messageGroup) {

    return userNeedRepository.updateMessageGroup(messageGroup);
  }
}
