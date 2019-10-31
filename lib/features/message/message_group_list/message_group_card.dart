import 'package:better_help/common/data/dao/message_dao.dart';
import 'package:better_help/common/data/models/message.dart';
import 'package:better_help/common/data/models/message_group.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/data/tranformer/message.dart';
import 'package:better_help/common/route/route.dart';
import 'package:better_help/common/utils/time_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MessageGroupCard extends StatelessWidget {
  final MessageGroup messageGroup;
  final User currentUser;

  const MessageGroupCard({
    Key key,
    @required this.messageGroup,
    @required this.currentUser,
  })  : assert(messageGroup != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Message>(
        stream: MessageDao.messageListStream(messageGroup.id)
            .transform(toLatestMessage),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final latestMessage = snapshot.data;

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                messageGroup.imageUrl,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(messageGroup.displayName),
                Text(getHourAndMinute(
                    latestMessage.updated ?? latestMessage.created)),
              ],
            ),
            subtitle: Text(latestMessage.content),
            onTap: () => goToMessageScreen(context, messageGroup, currentUser),
          );
        });
  }
}
