import 'package:better_help/common/dimens.dart';
import 'package:flutter/material.dart';

class ScreenSubtitle extends StatelessWidget {
  const ScreenSubtitle({
    Key key,
    @required this.subtitle,
  }) : super(key: key);

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final descriptionStyle = TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontSize: Dimens.h2_size);

    return Text(
      subtitle,
      style: descriptionStyle,
      textAlign: TextAlign.center,
    );
  }
}
