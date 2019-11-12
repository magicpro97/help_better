import 'package:better_help/common/data/models/message.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/dimens.dart';
import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageItem extends StatefulWidget {
    final Message message;
    final User currentUser;
    final User messageOwner;
    final bool isLastConversationMessage;
    final bool isLastMessage;
    final bool isFirstMessageGroup;

    const MessageItem({
        Key key,
        @required this.message,
        @required this.currentUser,
        @required this.messageOwner,
        @required this.isLastMessage,
        @required this.isLastConversationMessage,
        @required this.isFirstMessageGroup,
    })
        : assert(message != null),
            assert(currentUser != null),
            assert(messageOwner != null),
            assert(isLastMessage != null),
            assert(isLastConversationMessage != null),
            assert(isFirstMessageGroup != null),
            super(key: key);

    @override
    _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
    final screenUtil = ScreenUtil.getInstance();

    bool get isFromCurrentUser =>
        widget.currentUser.id == widget.message.userId;

    bool get showOtherUserAvatar =>
        !isFromCurrentUser && widget.isLastConversationMessage;
    
    bool get isFirstMessageGroup => widget.isFirstMessageGroup;

    bool get showMessageStatus => isFromCurrentUser && widget.isLastMessage;
    
    @override
    Widget build(BuildContext context) {
        return Container(child: _buildMessage());
    }

    Widget _buildMessage() {
        return Column(
            children: <Widget>[
                isFirstMessageGroup ? _buildConversationHeader() : Container(),
                Row(
                    children: <Widget>[
                        showOtherUserAvatar
                            ? _buildOtherUserImage()
                            : Container(),
                        Expanded(child: _buildMessageContent()),
                        showMessageStatus ? _buildMessageStatus() : Container(),
                    ],
                )
            ],
        );
    }

    Widget _buildMessageStatus() {
        final message = widget.message;
        if (message.isSentMessage()) {
            if (message.isSeenMessage()) {
                return _buildSeenIcon();
            } else if (message.isReceivedMessage()) {
                return _buildReceivedIcon();
            }
            return _buildSentIcon();
        } else {
            return _buildUnSendIcon();
        }
    }

    Widget _buildConversationHeader() =>
        Container(
            height: screenUtil.setHeight(Dimens.top_space),
            child: Text(
                widget.message.created.toString(),
                textAlign: TextAlign.center,
            ),
        );

    Widget _buildSeenIcon() =>
        widget.isLastConversationMessage ? CircleAvatar(
            maxRadius: screenUtil.setHeight(Dimens.messageHeight),
            backgroundImage: CachedNetworkImageProvider(
                widget.currentUser.photoUrl),) : Container(width: 20.0,);

    Widget _buildSentIcon() =>
        Icon(
            Icons.check_circle_outline,
            size: 20,
            color: Colors.blue,
        );

    Widget _buildReceivedIcon() =>
        Icon(
            Icons.check_circle,
            size: 20,
            color: Colors.blue,
        );

    Widget _buildUnSendIcon() =>
        Stack(
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

    Widget _buildOtherUserImage() =>
        CircleAvatar(
            backgroundImage:
            CachedNetworkImageProvider(widget.messageOwner.photoUrl),
        );
    
    Widget _buildMessageContent() {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Bubble(
                padding: const BubbleEdges.symmetric(vertical: 8.0),
                alignment: isFromCurrentUser ? Alignment.topRight : Alignment
                    .topLeft,
                color: isFromCurrentUser ? Colors.blue : Colors.grey[400],
                child: Text(widget.message.content),
            ),
        );
    }
}
