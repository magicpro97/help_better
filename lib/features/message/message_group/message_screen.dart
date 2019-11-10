import 'dart:developer';

import 'package:better_help/common/data/dao/message_group_dao.dart';
import 'package:better_help/common/data/models/message.dart';
import 'package:better_help/common/data/models/message_group.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/data/order_by.dart';
import 'package:better_help/common/ui/screen_loading.dart';
import 'package:better_help/features/message/message_group/bloc/bloc.dart';
import 'package:better_help/features/message/message_group_list/message_group_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/chat_bar.dart';
import 'components/message_item.dart';

class MessageScreen extends StatefulWidget {
    final MessageGroup messageGroup;
    final User currentUser;
    final List<User> otherUser;

    const MessageScreen({
        Key key,
        @required this.messageGroup,
        @required this.currentUser,
        @required this.otherUser,
    })  : assert(messageGroup != null),
            assert(currentUser != null),
            assert(otherUser != null),
            super(key: key);

    @override
    _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
    final messageGroupBloc = MessageGroupBloc();

    @override
    void dispose() {
        super.dispose();
        messageGroupBloc.close();
    }

    @override
    Widget build(BuildContext context) {
        final currentUser = widget.currentUser;
        final messageGroup = widget.messageGroup;
        final otherUser = widget.otherUser;

        return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
                middle: Text(messageGroup.displayName ?? displayName(otherUser)),
            ),
            child: SafeArea(
                child: Scaffold(
                    body: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                            Expanded(
                                child: FutureBuilder<List<User>>(
                                    future: MessageGroupDao.getOtherUser(
                                        groupId: messageGroup.id, currentUserId: currentUser.id),
                                    builder: (context, otherUserSnapshot) => otherUserSnapshot
                                        .hasData
                                        ? StreamBuilder<List<Message>>(
                                        stream: messageGroupBloc.messageListStream(
                                            messageGroupId: messageGroup.id,
                                            orderBy: OrderBy(field: 'created', desc: true)),
                                        builder: (context, snapshot) {
                                            if (snapshot.hasError) {
                                                log(snapshot.error.toString());
                                                return Center(
                                                    child: Text('Something went wrong.'),
                                                );
                                            }

                                            if (!snapshot.hasData) {
                                                return ScreenLoading();
                                            }

                                            final otherUsers = otherUserSnapshot.data;
                                            final messages = snapshot.data;
                                            List<Message> tempTimeGroupMessage = [];

                                            return ListView.builder(
                                                reverse: true,
                                                itemBuilder: (context, index) {
                                                    final message = messages[index];
                                                    Message lastConversationMessage = message;
                                                    bool isFirstMessageGroup = false;
                                                    if (index < messages.length - 1) {
                                                        if (message.created
                                                            .difference(
                                                            messages[index + 1].created)
                                                            .inMinutes >
                                                            3) {
                                                            isFirstMessageGroup = true;
                                                            if (tempTimeGroupMessage != null &&
                                                                tempTimeGroupMessage.isNotEmpty) {
                                                                lastConversationMessage =
                                                                    tempTimeGroupMessage.last;
                                                            }
                                                            tempTimeGroupMessage = [];
                                                        } else {
                                                            isFirstMessageGroup = false;
                                                            tempTimeGroupMessage.add(message);
                                                        }
                                                    } else {
                                                        isFirstMessageGroup = true;
                                                    }
                                                    final otherUser = otherUsers.firstWhere(
                                                            (user) => user.id == message.userId,
                                                        orElse: () => null);
                                                    final owner = currentUser.id == message.userId
                                                        ? currentUser
                                                        : otherUser;

                                                    return MessageItem(
                                                        message: message,
                                                        currentUser: currentUser,
                                                        messageOwner: owner,
                                                        isLastMessage:
                                                        lastConversationMessage != null,
                                                        isFirstMessageGroup: isFirstMessageGroup,
                                                    );
                                                },
                                                itemCount: messages.length,
                                            );
                                        })
                                        : Center(
                                        child: ScreenLoading(),
                                    ),
                                ),
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
