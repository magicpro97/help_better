import 'package:better_help/core/data/order_by.dart';
import 'package:better_help/features/message/data/models/message_model.dart';
import 'package:better_help/features/message/domain/entities/message.dart';

abstract class MessageRepository {
  Stream<List<Message>> getMessageListStream(
      {String messageGroupId, OrderBy orderBy});

  Future<void> createMessage(String messageGroupId, MessageModel message);
}
