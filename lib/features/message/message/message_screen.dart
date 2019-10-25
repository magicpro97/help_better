import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat_bar.dart';
import 'message_item.dart';

class MessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final messages = [
      MessageItem(),
      MessageItem(),
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
                  itemBuilder: (context, index) => MessageItem(),
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
