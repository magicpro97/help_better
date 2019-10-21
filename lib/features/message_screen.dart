import 'package:better_help/common/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final messages = [
      Message(),
      Message(),
    ];

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Ánh Phương'),
      ),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  itemBuilder: (context, index) => Message(),
                  itemCount: messages.length,
                ),
              ),
              ChatBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();

    return Container(
      child: ListTile(
        title: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(screenUtil.setHeight(20.0)),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Text(
                'Hello',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBar extends StatelessWidget {
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
                placeholder: 'Text message',
                style: textMessageStyle.copyWith(
                    fontSize: screenUtil.setSp(Dimens.body1_size)),
              ),
            ),
          ),
          CupertinoButton(child: Icon(CupertinoIcons.forward), onPressed: () {})
        ],
      ),
    );
  }
}
