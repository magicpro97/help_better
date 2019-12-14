import 'package:better_help/core/domain/entities/message_group.dart';
import 'package:better_help/features/message/domain/repositories/message_group_repository.dart';
import 'package:meta/meta.dart';

class GetMessageGroupStream {
  final MessageGroupRepository messageGroupRepository;

  GetMessageGroupStream({@required this.messageGroupRepository});

  Stream<List<MessageGroup>> call(String userId) =>
      messageGroupRepository.messageGroupListStream(userId: userId);
}
