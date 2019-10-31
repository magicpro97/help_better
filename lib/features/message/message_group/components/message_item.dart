import 'package:better_help/common/data/models/message.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageItem extends StatelessWidget {
  final Message message;
  final User user;
  final bool isLastMessage;

  const MessageItem({
    Key key,
    @required this.message,
    @required this.user,
    @required this.isLastMessage,
  })  : assert(message != null),
        assert(user != null),
        assert(isLastMessage != null),
        super(key: key);

  bool get isFormCurrentUser => user.id == message.userId;

  bool get showUserAvatar => isFormCurrentUser && isLastMessage;

  bool get showOtherUserAvatar => !isFormCurrentUser && isLastMessage;

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();

    return Container(
      child: ListTile(
        leading: showOtherUserAvatar
            ? CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(user.photoUrl),
              )
            : null,
        trailing: showUserAvatar
            ? CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(user.photoUrl),
              )
            : null,
        title: Row(
          mainAxisAlignment: isFormCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(screenUtil.setHeight(20.0)),
              decoration: BoxDecoration(
                color: isFormCurrentUser ? Colors.blue : Colors.grey[400],
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Text(
                message.content,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
