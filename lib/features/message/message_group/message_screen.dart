import 'dart:developer';

import 'package:better_help/common/data/models/message.dart';
import 'package:better_help/common/data/models/message_group.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/ui/screen_loading.dart';
import 'package:better_help/features/message/message_group/bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/chat_bar.dart';
import 'components/message_item.dart';

class MessageScreen extends StatefulWidget {
  final MessageGroup messageGroup;
  final User currentUser;

  const MessageScreen({
    Key key,
    @required this.messageGroup,
    @required this.currentUser,
  })
      : assert(messageGroup != null),
        assert(currentUser != null),
        super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final messageGroupBloc = MessageGroupBloc();

  @override
  void dispose() {
    super.dispose();
    log("CLOSSSSSSSSSSSSSSE");
    messageGroupBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.messageGroup.displayName),
      ),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: StreamBuilder<List<Message>>(
                    stream: messageGroupBloc.messageListStream(
                        messageGroupId: widget.messageGroup.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Something went wrong.'),
                        );
                      }

                      if (!snapshot.hasData) {
                        return ScreenLoading();
                      }

                      final messages = snapshot.data;

                      return ListView.builder(
                        shrinkWrap: true,
                        reverse: true,
                        itemBuilder: (context, index) =>
                            MessageItem(
                              message: messages[index],
                              user: widget.currentUser,
                              isLastMessage: messages.length - 1 == index,
                            ),
                        itemCount: messages.length,
                      );
                    }),
              ),
              ChatBar(
                messageGroupBloc: messageGroupBloc,
                userId: widget.currentUser.id,
                messageGroupId: widget.messageGroup.id,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
