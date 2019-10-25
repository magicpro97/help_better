import 'package:better_help/common/data/tranformer/message_group.dart';
import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/features/message/message_group/bloc/bloc.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'group_card/message_group_card.dart';

class MessageTab extends StatefulWidget {
  @override
  _MessageTabState createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  final messageBloc = MessageGroupBloc();

  @override
  void dispose() {
    super.dispose();
    messageBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();

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
                title: S
                    .of(context)
                    .main_message,
              ),
              Expanded(
                  child: StreamBuilder<List<MessageGroupCard>>(
                      stream: messageBloc.listMessageGroupStream
                          .transform(toMessageGroupCardList),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CupertinoActivityIndicator(),
                          );
                        }
                        final messageGroupCard = snapshot.data;

                        return ListView.builder(
                          itemBuilder: (context, index) =>
                          messageGroupCard[index],
                          itemCount: messageGroupCard.length,
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
