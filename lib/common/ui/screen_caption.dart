import 'package:better_help/common/dimens.dart';
import 'package:flutter/material.dart';

class ScreenCaption extends StatelessWidget {
  const ScreenCaption({
    Key key,
    @required this.subtitle,
  }) : super(key: key);

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_space),
      child: Text(
        subtitle,
        style: Theme.of(context).primaryTextTheme.caption,
        textAlign: TextAlign.center,
      ),
    );
  }
}
