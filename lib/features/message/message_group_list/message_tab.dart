import 'package:better_help/common/auth0/auth.dart';
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

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: FutureBuilder(
            future: Auth.currentUser(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: ScreenLoading(),
                );
              }
              final currentUser = snapshot.data;

              return Column(
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
                              .listMessageGroupList(userId: currentUser.id)
                              .transform(toMessageGroupCardList(
                                  currentUser: currentUser)),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return ScreenLoading();
                            }

                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                    'Something happens. ${snapshot.error}'),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
