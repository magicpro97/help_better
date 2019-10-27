import 'package:better_help/features/message/message/message_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '../screens.dart';

@optionalTypeArgs
Future<T> goToMainScreen<T extends Object>(BuildContext context,
    {bool deleteAllLastScreen, Object arguments}) {
  return (deleteAllLastScreen == null || deleteAllLastScreen == false)
      ? Navigator.pushNamed(context, Screens.MAIN.toString(),
      arguments: arguments)
      : Navigator.pushReplacementNamed(context, Screens.MAIN.toString(),
      arguments: arguments);
}

@optionalTypeArgs
Future<T> goToNicknameScreen<T extends Object>(BuildContext context,
    {bool deleteAllLastScreen, Object arguments}) {
  return (deleteAllLastScreen == null || deleteAllLastScreen == false)
      ? Navigator.pushNamed(context, Screens.NICKNAME.toString(),
      arguments: arguments)
      : Navigator.pushReplacementNamed(context, Screens.NICKNAME.toString(),
      arguments: arguments);
}

@optionalTypeArgs
Future<T> goToWelcomeScreen<T extends Object>(BuildContext context,
    {bool deleteAllLastScreen, Object arguments}) {
  return (deleteAllLastScreen == null || deleteAllLastScreen == false)
      ? Navigator.pushNamed(context, Screens.WELCOME.toString(),
      arguments: arguments)
      : Navigator.pushReplacementNamed(context, Screens.WELCOME.toString(),
      arguments: arguments);
}

@optionalTypeArgs
Future<T> goToMessageScreen<T extends Object>(BuildContext context,
    String groupId,
    {bool deleteAllLastScreen, Object arguments}) {
  return (deleteAllLastScreen == null || deleteAllLastScreen == false)
      ? Navigator.push(
    context, CupertinoPageRoute(builder: (context) => MessageScreen()),)
      : Navigator.pushReplacementNamed(context, Screens.MESSAGE.toString(),
      arguments: arguments);
}

@optionalTypeArgs
Future<T> goToUserNeedsScreen<T extends Object>(BuildContext context,
    {bool deleteAllLastScreen, Object arguments}) {
  return (deleteAllLastScreen == null || deleteAllLastScreen == false)
      ? Navigator.pushNamed(context, Screens.USER_TYPE.toString(),
      arguments: arguments)
      : Navigator.pushReplacementNamed(context, Screens.USER_TYPE.toString(),
      arguments: arguments);
}

@optionalTypeArgs
bool backToLastScreen<T extends Object>(BuildContext context, {T result}) =>
    Navigator.pop(context, result);
