import 'package:better_help/common/themes.dart';
import 'package:better_help/features/app/app.dart';
import 'package:better_help/features/app/bloc/app_bloc.dart';
import 'package:better_help/features/message/group_card/bloc/bloc.dart';
import 'package:better_help/features/message/message/bloc/message_bloc.dart';
import 'package:better_help/features/message/message_group/bloc/bloc.dart';
import 'package:better_help/features/user_setting/more/bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() => {Provider.debugCheckInvalidValueType = null, runApp(MyApp())};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: Theme(
        data: theme,
        child: App(),
      ),
      providers: [
        BlocProvider<AppBloc>.value(value: AppBloc()),
        ProxyProvider<AppBloc, MoreBloc>(
          builder: (context, appBloc, moreBloc) => MoreBloc(appBloc: appBloc),
          dispose: (context, moreBloc) => moreBloc.close(),
        ),
        ProxyProvider<AppBloc, MessageBloc>(
          builder: (context, appBloc, messageBloc) =>
              MessageBloc(appBloc: appBloc),
          dispose: (context, messageBloc) => messageBloc.close(),
        ),
        ProxyProvider<AppBloc, GroupCardBloc>(
          builder: (context, appBloc, groupCardBloc) =>
              GroupCardBloc(appBloc: appBloc),
          dispose: (context, groupCardBloc) => groupCardBloc.close(),
        ),
        ProxyProvider<AppBloc, MessageGroupBloc>(
          builder: (context, appBloc, messageGroupBloc) =>
              MessageGroupBloc(appBloc: appBloc),
        ),
      ],
    );
  }
}
