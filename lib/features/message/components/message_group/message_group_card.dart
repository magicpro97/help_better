import 'package:better_help/common/screens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MessageGroupCard extends StatelessWidget {
  final String displayName;
  final String lastMessage;
  final String lastMessageTime;
  final String imageUrl;

  const MessageGroupCard(
      {Key key,
      @required this.displayName,
      @required this.lastMessage,
      @required this.lastMessageTime,
      @required this.imageUrl})
      : assert(displayName != null),
        assert(lastMessage != null),
        assert(imageUrl != null),
        assert(imageUrl != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
          imageUrl,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(displayName),
          Text(lastMessageTime),
        ],
      ),
      subtitle: Text(lastMessage),
      onTap: () => Navigator.pushNamed(context, Screens.MESSAGE.toString()),
    );
  }
}
