import 'package:better_help/common/data/models/message.dart';
import 'package:better_help/common/dimens.dart';
import 'package:better_help/features/message/message_group/bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBar extends StatefulWidget {
  final String userId;
  final String messageGroupId;
  final MessageGroupBloc messageGroupBloc;

  const ChatBar({Key key,
    @required this.messageGroupBloc,
    @required this.messageGroupId,
    @required this.userId})
      : assert(messageGroupBloc != null),
        assert(messageGroupId != null),
        assert(userId != null),
        super(key: key);

  @override
  _ChatBarState createState() => _ChatBarState();
}

class _ChatBarState extends State<ChatBar> {
  final textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();
    final textMessageStyle = Theme.of(context).primaryTextTheme.body1;


    return Container(
      height: screenUtil.setHeight(150.0),
      color: Colors.grey.withOpacity(0.05),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                  left: screenUtil.setWidth(20.0),
                  top: screenUtil.setHeight(20.0),
                  bottom: screenUtil.setHeight(20.0)),
              child: CupertinoTextField(
                controller: textController,
                placeholder: 'Text message',
                style: textMessageStyle.copyWith(
                    fontSize: screenUtil.setSp(Dimens.body1_size)),
                onSubmitted: (content) {
                  if (content.isNotEmpty) {
                    widget.messageGroupBloc.add(AddMessageEvent(
                        content: textController.text,
                        messageType: MessageType.TEXT,
                        messageGroupId: widget.messageGroupId,
                        userId: widget.userId));
                    textController.text = "";
                  }
                },
              ),
            ),
          ),
          CupertinoButton(
              child: Icon(CupertinoIcons.forward),
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  widget.messageGroupBloc.add(AddMessageEvent(
                      content: textController.text,
                      messageType: MessageType.TEXT,
                      messageGroupId: widget.messageGroupId,
                      userId: widget.userId));
                  textController.text = "";
                }
              }),
        ],
      ),
    );
  }
}
