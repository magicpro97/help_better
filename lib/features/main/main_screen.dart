import 'package:better_help/features/main/sharing_tab.dart';
import 'package:better_help/features/message/message_tab.dart';
import 'package:better_help/features/user_setting/more/more_tab.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tabs = [
      MessageTab(),
      SharingTab(),
      MoreTab(),
    ];

    return CupertinoTabScaffold(
      tabBuilder: (BuildContext context, int index) {
        return tabs[index];
      },
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text(S.of(context).main_message)),
          BottomNavigationBarItem(
              icon: Icon(Icons.hearing),
              title: Text(S.of(context).main_share_room)),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              title: Text(S.of(context).main_more)),
        ],
      ),
    );
  }
}
