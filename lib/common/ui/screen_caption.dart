import 'package:better_help/common/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenCaption extends StatelessWidget {
  const ScreenCaption({
    Key key,
    @required this.caption,
  }) : super(key: key);

  final String caption;

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();
    final textCaptionStyle = Theme.of(context).primaryTextTheme.caption;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenUtil.setWidth(Dimens.horizontal_space)),
      child: Text(
        caption,
        style: textCaptionStyle.copyWith(
            fontSize: screenUtil.setSp(Dimens.h2_size)),
        textAlign: TextAlign.center,
      ),
    );
  }
}
