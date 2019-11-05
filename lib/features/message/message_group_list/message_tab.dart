import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/data/order_by.dart';
import 'package:better_help/common/data/tranformer/message_group.dart';
import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/ui/screen_loading.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/bloc.dart';
import 'message_group_card.dart';

class MessageTab extends StatefulWidget {
    final User currentUser;
    final List<User> friends;

    const MessageTab(
        {Key key, @required this.currentUser, @required this.friends})
        : assert(currentUser != null),
            assert(friends != null),
            super(key: key);

    @override
    _MessageTabState createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
    final messageGroupListBloc = MessageGroupListBloc();

    @override
    void dispose() {
        super.dispose();
        messageGroupListBloc.close();
    }

    @override
    Widget build(BuildContext context) {
        final screenUtil = ScreenUtil.getInstance();
        final currentUser = widget.currentUser;
        final friends = widget.friends;

        return SafeArea(
            child: Scaffold(
                body: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            SizedBox(
                                height: screenUtil.setHeight(Dimens.top_space),
                            ),
                            ScreenTitle(
                                title: S.of(context).main_message,
                            ),
                            Expanded(
                                child: StreamBuilder<List<MessageGroupCard>>(
                                    stream: messageGroupListBloc
                                        .listMessageGroupList(
                                        userId: currentUser.id,
                                        orderBy: OrderBy(field: 'updated', desc: true))
                                        .transform(toMessageGroupCardList(
                                        currentUser: currentUser, friends: friends)),
                                    builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                            return ScreenLoading();
                                        }

                                        if (snapshot.hasError) {
                                            return Center(
                                                child: Text('Something happens. ${snapshot.error}'),
                                            );
                                        }
                                        final messageGroupCard = snapshot.data;

                                        return ListView.builder(
                                            itemBuilder: (context, index) =>
                                            messageGroupCard[index],
                                            itemCount: messageGroupCard.length,
                                        );
                                    }))
                        ],
                    ),
                ),
            ),
        );
    }
}
