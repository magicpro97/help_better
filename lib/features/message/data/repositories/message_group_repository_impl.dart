import 'package:better_help/core/data/order_by.dart';
import 'package:better_help/core/domain/entities/message_group.dart';
import 'package:better_help/features/message/data/datasources/message_group_datasource.dart';
import 'package:better_help/features/message/domain/repositories/message_group_repository.dart';
import 'package:meta/meta.dart';

class MessageGroupRepositoryImpl implements MessageGroupRepository {
  final MessageGroupDataSource messageGroupDataSource;

  MessageGroupRepositoryImpl({@required this.messageGroupDataSource});

  @override
  Stream<List<MessageGroup>> messageGroupStream(
          {String userId, OrderBy orderBy}) =>
      messageGroupDataSource.messageGroupListStream(
          userId: userId, orderBy: orderBy);
}
