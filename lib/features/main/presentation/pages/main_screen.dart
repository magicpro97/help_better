import 'dart:developer';

import 'package:better_help/common/ui/screen_loading.dart';
import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/features/app/presentations/bloc/app_bloc.dart';
import 'package:better_help/features/app/presentations/widgets/notification.dart';
import 'package:better_help/features/main/presentation/bloc/bloc.dart';
import 'package:better_help/features/main/presentation/pages/sharing_tab.dart';
import 'package:better_help/features/message/presentation/pages/message_tab.dart';
import 'package:better_help/features/need_help/presentation/need_help_tab.dart';
import 'package:better_help/features/user_setting/presentations/pages/more_tab.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key key,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainBloc mainBloc;

  @override
  void initState() {
    super.initState();
    // ignore: close_sinks
    final appBloc = BlocProvider.of<AppBloc>(context);
    appBloc.notificationStream.listen(
        (data) => PushNotification.show(context: context, notification: data));
    mainBloc = BlocProvider.of<MainBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final user =
        (ModalRoute.of(context).settings.arguments as MainArgument).user;

    return StreamBuilder<User>(
      stream: mainBloc.getUserStream(user.id),
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
          future: mainBloc.getUserFriends(user.id),
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
                  MessageTab(
                    currentUser: user,
                    friends: friends,
                  ),
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
                      title: Text(S.of(context).main_message)),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.hearing),
                      title: Text(S.of(context).main_share_room)),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.group_solid),
                      title: Text(S.of(context).main_need_help)),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.more_horiz),
                      title: Text(S.of(context).main_more)),
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
