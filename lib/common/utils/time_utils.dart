import 'package:better_help/generated/i18n.dart';
import 'package:flutter/widgets.dart';

String getAHaftDayName(BuildContext context) {
  final DateTime now = DateTime.now();
  final hour = now.hour;
  if (hour >= 0 && hour < 12) {
    return S.of(context).morning;
  } else if (hour >= 12 && hour < 18) {
    return S.of(context).evening;
  } else {
    return S.of(context).night;
  }
}

String getHourAndMinute(DateTime dateTime) =>
    '${dateTime.hour}:${dateTime.minute}';
