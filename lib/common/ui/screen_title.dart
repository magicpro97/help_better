import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../dimens.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();
    final textTitleStyle = Theme.of(context).primaryTextTheme.title;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenUtil.setWidth(Dimens.horizontal_space)),
      child: Text(
        title,
        style:
            textTitleStyle.copyWith(fontSize: screenUtil.setSp(Dimens.h1_size)),
        textAlign: TextAlign.center,
      ),
    );
  }
}
