import 'package:better_help/core/data/order_by.dart';
import 'package:better_help/features/message/data/datasources/message_datasource.dart';
import 'package:better_help/features/message/domain/entities/message.dart';
import 'package:better_help/features/message/domain/repositories/message_repository.dart';
import 'package:meta/meta.dart';

class MessageRepositoryImpl extends MessageRepository {
  final MessageDataSource messageDataSource;

  MessageRepositoryImpl({@required this.messageDataSource});

  @override
  Stream<List<Message>> getMessageListStream(
          {String messageGroupId, OrderBy orderBy}) =>
      messageDataSource.messageListStream(
          messageGroupId: messageGroupId, orderBy: orderBy);
}
