import 'package:better_help/common/data/models/message.dart';
import 'package:better_help/common/data/models/message_group.dart';
import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'message_group_card.dart';

class MessageTab extends StatelessWidget {
  final groups = [
    MessageGroupCard(
      messageGroup: MessageGroup(
          id: 'id',
          displayName: 'Dương Nguyễn',
          imageUrl:
          'https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?cs=srgb&dl=beauty-bloom-blue-67636.jpg&fm=jpg',
          created: DateTime.now()),
      lastMessage: Message(
        id: 'a',
        userId: 'a',
        content: ['a'],
        type: MessageType.TEXT,
        created: DateTime.now(),
      ),
    ),
  ];

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
                title: S.of(context).main_message,
              ),
              Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => groups[index],
                    itemCount: groups.length,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
