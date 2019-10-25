import 'package:better_help/common/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NeedsButton extends StatelessWidget {
  final String content;
  final Color color;
  final Function onPress;

  const NeedsButton(
      {Key key, @required this.content, @required this.color, this.onPress})
      : assert(content != null),
        assert(color != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();

    final contentStyle = TextStyle(
      fontSize: screenUtil.setSp(Dimens.h2_size),
      color: Colors.white,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
          bottom: screenUtil.setHeight(Dimens.normal_space),
          left: screenUtil.setHeight(Dimens.horizontal_space),
          right: screenUtil.setHeight(Dimens.horizontal_space)),
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              screenUtil.setWidth(Dimens.optionButtonBorderRadius)),
        ),
        elevation: Dimens.elevation,
        child: Padding(
          padding: EdgeInsets.all(
              screenUtil.setHeight(Dimens.optionButtonTextPadding)),
          child: Text(
            content,
            textAlign: TextAlign.center,
            style: contentStyle,
          ),
        ),
        onPressed: onPress,
      ),
    );
  }
}
