import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dimens.dart';

final textPrimaryColor = Colors.black;
final textTitleFontWeight = FontWeight.bold;
final textTitleSize = Dimens.h1_size;
final textTitleStyle = TextStyle(
  color: textPrimaryColor,
  fontWeight: textTitleFontWeight,
  fontSize: textTitleSize,
);

final textCaptionFontWeight = FontWeight.w500;
final textCaptionSize = Dimens.h2_size;
final textCaptionStyle = TextStyle(
    color: textPrimaryColor,
    fontWeight: textCaptionFontWeight,
    fontSize: textTitleSize);

final textButtonSize = textCaptionSize;
final textButtonColor = Colors.white;
final textButtonStyle = TextStyle(
  fontSize: textButtonSize,
  color: textButtonColor,
);

final textBody1Size = Dimens.body1_size;
final textBody1Color = Colors.black;
final textBody1Style = TextStyle(
  color: textBody1Color,
  fontSize: textBody1Size,
);

final theme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  primaryTextTheme: TextTheme(
    title: textTitleStyle,
    caption: textCaptionStyle,
    display1: textButtonStyle,
    body1: textBody1Style,
  ),
);
