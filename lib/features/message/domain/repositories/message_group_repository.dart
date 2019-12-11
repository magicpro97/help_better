import 'package:better_help/core/data/order_by.dart';
import 'package:better_help/core/domain/entities/message_group.dart';
import 'package:meta/meta.dart';

abstract class MessageGroupRepository {
  Stream<List<MessageGroup>> messageGroupStream(
      {@required String userId, OrderBy orderBy});
}
