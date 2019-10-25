import 'package:better_help/common/data/models/message.dart';
import 'package:better_help/common/data/models/message_group.dart';
import 'package:better_help/common/screens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MessageGroupCard extends StatelessWidget {
  final MessageGroup messageGroup;
  final Message lastMessage;

  const MessageGroupCard({
    Key key,
    @required this.messageGroup,
    @required this.lastMessage,
  })
      : assert(messageGroup != null),
        assert(lastMessage != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Text(lastMessage.created.toString()),
        ],
      ),
      subtitle: Text(lastMessage.content.first),
      onTap: () => Navigator.pushNamed(context, Screens.MESSAGE.toString()),
    );
  }
}
