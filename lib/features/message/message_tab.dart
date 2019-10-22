import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/screens.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageGroup {
  final String displayName;
  final String lastMessage;
  final String lastMessageTime;
  final String userUrl;

  MessageGroup({
    this.displayName,
    this.lastMessage,
    this.lastMessageTime,
    this.userUrl,
  });
}

class MessageTab extends StatelessWidget {
  final groups = [
    MessageGroupCard(
        displayName: 'Dương Nguyễn',
        lastMessage: 'Perter asdasd ád',
        lastMessageTime: '10:00',
        imageUrl:
            'https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?cs=srgb&dl=beauty-bloom-blue-67636.jpg&fm=jpg')
  ];

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: screenUtil.setHeight(Dimens.top_space),
              ),
              ScreenTitle(
                title: S.of(context).main_message,
              ),
              Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) => groups[index],
                itemCount: groups.length,
              )),
            ],
          ),
        ),
      ),
    );
  }
}

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
