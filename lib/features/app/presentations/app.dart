import 'package:better_help/common/screens.dart';
import 'package:better_help/features/authentication/presentations/welcome_screen.dart';
import 'package:better_help/features/main/presentation/pages/main_screen.dart';
import 'package:better_help/features/user_setting/presentations/pages/nickname_screen.dart';
import 'package:better_help/features/user_setting/presentations/pages/user_needs_screen.dart';
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
    appBloc.add(ConfigFCM());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
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
