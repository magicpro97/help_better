import 'package:better_help/common/screens.dart';
import 'package:better_help/features/app/bloc/app_bloc.dart';
import 'package:better_help/features/auth0/ui/welcome_screen.dart';
import 'package:better_help/features/main/main_screen.dart';
import 'package:better_help/features/user_setting/nickname/nickname_screen.dart';
import 'package:better_help/features/user_setting/user_needs/user_needs_screen.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AppBloc appBloc = AppBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    appBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) => CupertinoApp(
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
          Screens.WELCOME.toString(): (context) => WelcomeScreen(),
          Screens.NICKNAME.toString(): (context) => NicknameScreen(),
          Screens.USER_TYPE.toString(): (context) => UserNeedsScreen(),
          Screens.MAIN.toString(): (context) => MainScreen(),
        },
        onGenerateRoute: (settings) => CupertinoPageRoute(
            settings: settings,
            builder: (context) {
              ScreenUtil.instance =
                  ScreenUtil(width: 1080, height: 1920, allowFontScaling: true)
                    ..init(context);
              return !snapshot.hasData || snapshot.hasError
                  ? WelcomeScreen()
                  : MainScreen();
            }),
      ),
    );
  }
}
