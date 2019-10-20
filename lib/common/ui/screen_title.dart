import 'package:flutter/material.dart';

import '../dimens.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_space),
      child: Text(
        title,
        style: Theme.of(context).primaryTextTheme.title,
        textAlign: TextAlign.center,
      ),
    );
  }
}
