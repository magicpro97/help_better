import 'package:flutter/widgets.dart';

import '../screens.dart';

@optionalTypeArgs
Future<T> goToMainScreen<T extends Object>(BuildContext context,
    {bool deleteAllLastScreen, Object arguments}) {
  return (deleteAllLastScreen == null || deleteAllLastScreen == false)
      ? Navigator.pushNamed(context, Screens.MAIN.toString(),
          arguments: arguments)
      : Navigator.pushNamedAndRemoveUntil(
          context, Screens.MAIN.toString(), (route) => false,
          arguments: arguments);
}

@optionalTypeArgs
Future<T> goToNicknameScreen<T extends Object>(BuildContext context,
    {bool deleteAllLastScreen, Object arguments}) {
  return (deleteAllLastScreen == null || deleteAllLastScreen == false)
      ? Navigator.pushNamed(context, Screens.NICKNAME.toString(),
          arguments: arguments)
      : Navigator.pushNamedAndRemoveUntil(
          context, Screens.NICKNAME.toString(), (route) => false,
          arguments: arguments);
}

@optionalTypeArgs
Future<T> goToWelcomeScreen<T extends Object>(BuildContext context,
    {bool deleteAllLastScreen, Object arguments}) {
  return (deleteAllLastScreen == null || deleteAllLastScreen == false)
      ? Navigator.pushNamed(context, Screens.WELCOME.toString(),
          arguments: arguments)
      : Navigator.pushNamedAndRemoveUntil(
          context, Screens.WELCOME.toString(), (route) => false,
          arguments: arguments);
}

@optionalTypeArgs
Future<T> goToMessageScreen<T extends Object>(BuildContext context,
    {bool deleteAllLastScreen, Object arguments}) {
  return (deleteAllLastScreen == null || deleteAllLastScreen == false)
      ? Navigator.pushNamed(context, Screens.MESSAGE.toString(),
          arguments: arguments)
      : Navigator.pushNamedAndRemoveUntil(
          context, Screens.MESSAGE.toString(), (route) => false,
          arguments: arguments);
}

@optionalTypeArgs
Future<T> goToUserNeedsScreen<T extends Object>(BuildContext context,
    {bool deleteAllLastScreen, Object arguments}) {
  return (deleteAllLastScreen == null || deleteAllLastScreen == false)
      ? Navigator.pushNamed(context, Screens.USER_TYPE.toString(),
          arguments: arguments)
      : Navigator.pushNamedAndRemoveUntil(
          context, Screens.USER_TYPE.toString(), (route) => false,
          arguments: arguments);
}

@optionalTypeArgs
bool backToLastScreen<T extends Object>(BuildContext context, {T result}) =>
    Navigator.pop(context, result);
