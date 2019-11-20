import 'dart:developer';

import 'package:better_help/common/data/dao/message_group_dao.dart';
import 'package:better_help/common/data/models/message.dart';
import 'package:better_help/common/data/models/message_group.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/data/order_by.dart';
import 'package:better_help/common/ui/screen_loading.dart';
import 'package:better_help/features/app/bloc/app_bloc.dart';
import 'package:better_help/features/app/components/notification.dart';
import 'package:better_help/features/message/message_group/bloc/bloc.dart';
import 'package:better_help/features/message/message_group_list/message_group_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    })
        : assert(messageGroup != null),
            assert(currentUser != null),
            assert(otherUser != null),
            super(key: key);

    @override
    _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen>
    with WidgetsBindingObserver {
    static const _TAG = "MessageScreen";
    final messageGroupBloc = MessageGroupBloc();

    @override
    void initState() {
        super.initState();
        messageGroupBloc.add(ComeInEvent(
            messageGroup: widget.messageGroup,
            currentUser: widget.currentUser));
        // ignore: close_sinks
        final appBloc = BlocProvider.of<AppBloc>(context);
        appBloc.notificationStream.listen((data) =>
            PushNotification.show(context: context, notification: data));
        WidgetsBinding.instance.addObserver(this);
    }

    @override
    void dispose() {
        WidgetsBinding.instance.removeObserver(this);
        super.dispose();
        messageGroupBloc.close();
    }

    @override
    void didChangeAppLifecycleState(AppLifecycleState state) {
        super.didChangeAppLifecycleState(state);
        switch (state) {
            case AppLifecycleState.resumed:
                messageGroupBloc.add(ComeInEvent(
                    messageGroup: widget.messageGroup,
                    currentUser: widget.currentUser));
                break;
            case AppLifecycleState.inactive:
                messageGroupBloc
                    .add(GoOutEvent(messageGroup: widget.messageGroup,
                    currentUser: widget.currentUser));
                break;
            case AppLifecycleState.paused:
                break;
            case AppLifecycleState.suspending:
                break;
        }
    }

    @override
    Widget build(BuildContext context) {
        final currentUser = widget.currentUser;
        final messageGroup = widget.messageGroup;
        final otherUser = widget.otherUser;

        return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
                middle: Text(
                    messageGroup.displayName ?? displayName(otherUser)),
            ),
            child: WillPopScope(
                onWillPop: () => _onWillPop(currentUser, messageGroup),
                child: SafeArea(
                    child: Scaffold(
                        body: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                                Expanded(
                                    child: messageGroup.memberIds.length > 2
                                        ? _buildWithManyOtherUser(
                                        messageGroup.id, currentUser.id)
                                        : _buildMessageList(
                                        messageGroup.id, otherUser,
                                        currentUser.id),
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
            ),
        );
    }

    Widget _buildWithManyOtherUser(String messageGroupId,
        String currentUserId) =>
        FutureBuilder<List<User>>(
            future: MessageGroupDao.getOtherUser(
                groupId: messageGroupId,
                currentUserId: currentUserId),
            builder: (context, otherUserSnapshot) {
                if (otherUserSnapshot.hasError) {
                    log(otherUserSnapshot.error
                        .toString(), name: _TAG);
                    return Center(
                        child: Text(
                            'Something went wrong.'),
                    );
                }
                if (!otherUserSnapshot.hasData) {
                    return ScreenLoading();
                }
            
                if (otherUserSnapshot.data
                    .isEmpty) {
                    return Container();
                }
            
                return _buildMessageList(
                    messageGroupId, otherUserSnapshot.data, currentUserId);
            });

    StreamBuilder<List<Message>> _buildMessageList(String messageGroupId,
        List<User> otherUsers, String currentUserId) {
        return StreamBuilder<List<Message>>(
            stream: messageGroupBloc
                .messageListStream(
                messageGroupId: messageGroupId,
                orderBy: OrderBy(
                    field: 'created',
                    desc: true)),
            builder: (context, snapshot) {
                if (snapshot.hasError) {
                    log(snapshot.error
                        .toString(),
                        name: _TAG);
                    return Center(
                        child: Text(
                            'Something went wrong.'),
                    );
                }
            
                if (!snapshot.hasData) {
                    return ScreenLoading();
                }
            
                final messages = snapshot
                    .data;
            
                if (messages.length < 1) {
                    return Container();
                }
            
                final lastCurrentUserMessage =
                messages.firstWhere(
                        (message) =>
                    message.userId ==
                        currentUserId,
                    orElse: () => null);
            
                List<
                    Message> tempTimeGroupMessage = [
                ];
            
                return ListView.builder(
                    reverse: true,
                    itemBuilder: (context,
                        index) {
                        final message = messages[index];
                        Message lastConversationMessage = message;
                        bool isFirstMessageGroup = false;
                        if (index < messages
                            .length - 1) {
                            if (message
                                .created
                                .difference(
                                messages[index +
                                    1]
                                    .created)
                                .inMinutes >
                                3) {
                                isFirstMessageGroup =
                                true;
                                if (tempTimeGroupMessage !=
                                    null &&
                                    tempTimeGroupMessage
                                        .isNotEmpty) {
                                    lastConversationMessage =
                                        tempTimeGroupMessage
                                            .last;
                                }
                                tempTimeGroupMessage =
                                [];
                            } else {
                                isFirstMessageGroup =
                                false;
                                tempTimeGroupMessage
                                    .add(
                                    message);
                            }
                        } else {
                            isFirstMessageGroup =
                            true;
                        }
                    
                        return MessageItem(
                            message: message,
                            currentUser: widget.currentUser,
                            otherUsers: otherUsers,
                            isLastCurrentUserMessage:
                            lastCurrentUserMessage
                                ?.userId ==
                                message
                                    ?.userId &&
                                lastCurrentUserMessage
                                    ?.id ==
                                    message
                                        ?.id ??
                                false,
                            isLastConversationMessage:
                            lastConversationMessage !=
                                null,
                            isLastMessage: index ==
                                0,
                            isFirstMessageGroup: isFirstMessageGroup,
                        );
                    },
                    itemCount: messages
                        .length,
                    padding:
                    const EdgeInsets
                        .symmetric(
                        horizontal: 8.0),
                );
            });
    }
    
    Future<bool> _onWillPop(User currentUser, MessageGroup messageGroup) async {
        messageGroupBloc
            .add(
            GoOutEvent(messageGroup: messageGroup, currentUser: currentUser));
        return true;
    }
}
