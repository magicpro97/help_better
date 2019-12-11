import 'package:better_help/features/message/domain/entities/message.dart';
import 'package:better_help/features/message/domain/repositories/message_repository.dart';

class GetMessageListStream {
  final MessageRepository messageRepository;

  GetMessageListStream({this.messageRepository});

  Stream<List<Message>> call(String messageGroupId) =>
      messageRepository.getMessageListStream(messageGroupId: messageGroupId);
}
