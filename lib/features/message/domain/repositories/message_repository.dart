import 'package:better_help/core/data/order_by.dart';
import 'package:better_help/features/message/domain/entities/message.dart';

abstract class MessageRepository {
  Stream<List<Message>> getMessageListStream(
      {String messageGroupId, OrderBy orderBy});
}
