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
    final screenUtil = ScreenUtil.getInstance();

    bool get isFromCurrentUser => widget.currentUser.id == widget.message.userId;

    bool get showOtherUserAvatar => !isFromCurrentUser && widget.isLastMessage;

    bool get isFirstMessageGroup => widget.isFirstMessageGroup;

    bool get isSentMessage => widget.message.status == MessageStatus.SENT;

    bool get isReceivedMessage => widget.message.status == MessageStatus.RECEIVED;

    bool get isSeenMessage => widget.message.status == MessageStatus.SEEN;

    bool get showMessageStatus => isFromCurrentUser;

    @override
    Widget build(BuildContext context) {
        return Container(child: _buildMessage());
    }

    Widget _buildMessage() {
        return Column(
            children: <Widget>[
                isFirstMessageGroup
                    ? Column(
                    children: <Widget>[
                        Text(
                            widget.message.created.toString(),
                            textAlign: TextAlign.center,
                        ),
                        SizedBox(
                            height: screenUtil.setHeight(Dimens.normal_space),
                        ),
                    ],
                )
                    : Container(),
                ListTile(
                    leading: showOtherUserAvatar ? _buildOtherUserImage() : null,
                    title: _buildMessageContent(),
                    trailing: showMessageStatus ? _buildMessageStatus() : null,
                ),
            ],
        );
    }

    Widget _buildMessageStatus() {
        if (isSentMessage) {
            return _buildSentIcon();
        } else if (isSeenMessage) {
            return _buildSeenIcon();
        } else if (isReceivedMessage) {
            return _buildReceivedIcon();
        } else {
            return _buildUnSendIcon();
        }
    }

    Widget _buildSeenIcon() => Container();

    Widget _buildSentIcon() => Icon(
        Icons.check_circle_outline,
        size: 20,
        color: Colors.blue,
    );

    Widget _buildReceivedIcon() => Icon(
        Icons.check_circle,
        size: 20,
        color: Colors.blue,
    );

    Widget _buildUnSendIcon() => Stack(
        alignment: Alignment.center,
        children: <Widget>[
            Icon(
                Icons.lens,
                size: 20.0,
                color: Colors.blue,
            ),
            Icon(
                Icons.lens,
                size: 16.0,
                color: Colors.white,
            ),
        ],
    );

    Widget _buildOtherUserImage() => CircleAvatar(
        backgroundImage:
        CachedNetworkImageProvider(widget.messageOwner.photoUrl),
    );

    Widget _buildMessageContent() {
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
