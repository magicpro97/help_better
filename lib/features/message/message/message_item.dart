import 'package:better_help/common/data/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageItem extends StatelessWidget {
  final Message message;
  final bool isSendingMessage;

  const MessageItem(
      {Key key, @required this.message, @required this.isSendingMessage})
      : assert(message != null),
        assert(isSendingMessage != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();

    return Container(
      child: ListTile(
        title: Row(
          mainAxisAlignment: isSendingMessage
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(screenUtil.setHeight(20.0)),
              decoration: BoxDecoration(
                color: isSendingMessage ? Colors.blue : Colors.grey[400],
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
