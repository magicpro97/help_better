import 'package:after_layout/after_layout.dart';
import 'package:better_help/common/data/tranformer/message_group.dart';
import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/ui/screen_loading.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/features/message/group_card/message_group_card.dart';
import 'package:better_help/features/message/message_group/bloc/bloc.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MessageTab extends StatefulWidget {
  @override
  _MessageTabState createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab>
    with AfterLayoutMixin<MessageTab> {
  MessageGroupBloc messageGroupBloc;
  bool isInitialize = false;

  @override
  void dispose() {
    super.dispose();
    messageGroupBloc.close();
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
              isInitialize
                  ? Expanded(
                  child: StreamBuilder<List<MessageGroupCard>>(
                      stream: messageGroupBloc.listMessageGroupStream
                          .transform(toMessageGroupCardList),
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
                  : Center(child: ScreenLoading()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    messageGroupBloc = Provider.of<MessageGroupBloc>(context);
    messageGroupBloc.initStream();
    setState(() {
      isInitialize = true;
    });
  }
}
