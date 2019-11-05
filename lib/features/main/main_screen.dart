import 'dart:developer';

import 'package:better_help/common/data/dao/user_dao.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/ui/screen_loading.dart';
import 'package:better_help/features/main/sharing_tab.dart';
import 'package:better_help/features/message/message_group_list/message_tab.dart';
import 'package:better_help/features/need_help/need_help_tab.dart';
import 'package:better_help/features/user_setting/more/more_tab.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bloc/bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key key,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final mainBloc = MainBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    mainBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final user =
        (ModalRoute
            .of(context)
            .settings
            .arguments as MainArgument).user;

    return StreamBuilder<User>(
      stream: UserDao.userStream(user.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          log(snapshot.data.toString());
        }

        if (!snapshot.hasData) {
          return CupertinoPageScaffold(
            child: Center(
              child: ScreenLoading(),
            ),
          );
        }
        final user = snapshot.data;

        return FutureBuilder(
          future: UserDao.getHasKnowUser(currentUserId: user.id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              log(snapshot.data.toString());
            }

            if (!snapshot.hasData) {
              return CupertinoPageScaffold(
                child: Center(
                  child: ScreenLoading(),
                ),
              );
            }
            final friends = snapshot.data;

            return CupertinoTabScaffold(
              tabBuilder: (BuildContext context, int index) {
                final tabs = [
                  MessageTab(currentUser: user, friends: friends,),
                  SharingTab(),
                  NeedHelpTab(
                    currentUser: user,
                    friends: friends,
                  ),
                  MoreTab(),
                ];

                return tabs[index];
              },
              tabBar: CupertinoTabBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.message),
                      title: Text(S
                          .of(context)
                          .main_message)),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.hearing),
                      title: Text(S
                          .of(context)
                          .main_share_room)),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.group_solid),
                      title: Text(S
                          .of(context)
                          .main_need_help)),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.more_horiz),
                      title: Text(S
                          .of(context)
                          .main_more)),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class MainArgument {
  final User user;

  MainArgument({@required this.user}) : assert(user != null);
}
