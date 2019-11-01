import 'package:better_help/common/data/models/message.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/dimens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageItem extends StatefulWidget {
  final Message message;
  final User currentUser;
  final User messageOwner;
  final bool isLastMessage;
  final bool isFirstMessageGroup;

  const MessageItem({
    Key key,
    @required this.message,
    @required this.currentUser,
    @required this.messageOwner,
    @required this.isLastMessage,
    @required this.isFirstMessageGroup,
  })  : assert(message != null),
        assert(currentUser != null),
        assert(messageOwner != null),
        assert(isLastMessage != null),
        assert(isFirstMessageGroup != null),
        super(key: key);

  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  bool get isFromCurrentUser => widget.currentUser.id == widget.message.userId;

  bool get showOtherUserAvatar => !isFromCurrentUser && widget.isLastMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.isFirstMessageGroup
          ? _buildMessage()
          : _buildMessageNoHeader(),
    );
  }

  Widget _buildMessage() {
    final screenUtil = ScreenUtil.getInstance();

    return Column(
      children: <Widget>[
        Text(
          widget.message.created.toString(),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: screenUtil.setHeight(Dimens.normal_space),
        ),
        ListTile(
          leading: showOtherUserAvatar ? _buildOtherUserImage() : null,
          title: _buildMessageContent(),
        ),
      ],
    );
  }

  Widget _buildMessageNoHeader() {
    return ListTile(
      leading: showOtherUserAvatar ? _buildOtherUserImage() : null,
      title: _buildMessageContent(),
    );
  }

  Widget _buildOtherUserImage() =>
      CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
            widget.messageOwner.photoUrl),
      );

  Widget _buildMessageContent() {
    final screenUtil = ScreenUtil.getInstance();

    return Row(
      mainAxisAlignment:
      isFromCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(screenUtil.setHeight(20.0)),
          decoration: BoxDecoration(
            color: isFromCurrentUser ? Colors.blue : Colors.grey[400],
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Text(
            widget.message.content,
          ),
        ),
      ],
    );
  }
}
