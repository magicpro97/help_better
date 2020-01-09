import 'package:better_help/features/message/data/models/message_model.dart';
import 'package:better_help/features/message/domain/repositories/message_repository.dart';
import 'package:meta/meta.dart';

class CreateMessage {
  final MessageRepository messageRepository;

  CreateMessage({@required this.messageRepository});

  Future<void> call(String messageGroupId, MessageModel message) {
    return messageRepository.createMessage(messageGroupId, message);
  }
}