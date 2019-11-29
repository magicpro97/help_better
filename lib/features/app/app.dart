import 'dart:developer';
import 'dart:io';

import 'package:better_help/common/auth0/auth.dart';
import 'package:better_help/common/screens.dart';
import 'package:better_help/features/auth0/ui/welcome_screen.dart';
import 'package:better_help/features/main/main_screen.dart';
import 'package:better_help/features/user_setting/nickname/nickname_screen.dart';
import 'package:better_help/features/user_setting/user_needs/user_needs_screen.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/bloc.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  //static const _APP = "APP";
  AppBloc appBloc;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    appBloc.add(AppStateChange(state: state));
  }

  @override
  void initState() {
    super.initState();
    appBloc = BlocProvider.of<AppBloc>(context);
    WidgetsBinding.instance.addObserver(this);
    Auth.fcmConfigure(
      onMessage: (message) async {
        log(message.toString(), name: "onMessage");
      },
      onLaunch: (message) async {
        log(message.toString(), name: "onLauch");
      },
      onResume: (message) async {
        log(message.toString(), name: "onResume");
      },
      onBackgroundMessage: Platform.isIOS ? null : Auth.messageBackground,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    appBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        primaryColor: Color(0xff54bd98),
        brightness: Brightness.light,
        primaryContrastingColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) => S.of(context).app_name,
      localizationsDelegates: const <LocalizationsDelegate>[
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback:
          S.delegate.resolution(fallback: const Locale('en', '')),
      localeListResolutionCallback:
          S.delegate.listResolution(fallback: const Locale('en', '')),
      routes: {
        Screens.WELCOME.toString(): (context) {
          initScreenUtil(context);
          return WelcomeScreen();
        },
        Screens.NICKNAME.toString(): (context) => NicknameScreen(),
        Screens.USER_TYPE.toString(): (context) => UserNeedsScreen(),
        Screens.MAIN.toString(): (context) => MainScreen(),
      },
      initialRoute: Screens.WELCOME.toString(),
    );
  }

  void initScreenUtil(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(allowFontScaling: true)..init(context);
  }
}
