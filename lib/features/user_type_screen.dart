import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/screens.dart';
import 'package:better_help/common/ui/screen_caption.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();

    return CupertinoPageScaffold(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: ScreenTitle(
                title: S.of(context).user_type_title,
              ),
            ),
            SizedBox(
              height: screenUtil.setHeight(Dimens.large_space),
            ),
            _buildOptionButton(
                context, S.of(context).option_teenage, Colors.yellow[700]),
            _buildOptionButton(context, S.of(context).option_love, Colors.pink),
            _buildOptionButton(
                context, S.of(context).option_family, Colors.blue),
            _buildOptionButton(
                context, S.of(context).option_go_a_head, Colors.greenAccent),
            SizedBox(
              height: screenUtil.setHeight(Dimens.large_space),
            ),
            Divider(
              height: 1.0,
              thickness: 3.0,
              indent: screenUtil.setHeight(Dimens.horizontal_space),
              endIndent: screenUtil.setHeight(Dimens.horizontal_space),
            ),
            SizedBox(
              height: screenUtil.setHeight(Dimens.normal_space),
            ),
            ScreenCaption(
              caption: S.of(context).user_type_subtitle,
            ),
            SizedBox(
              height: screenUtil.setHeight(Dimens.normal_space),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: Dimens.elevation,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  S.of(context).user_type_volunteer_register,
                  style: TextStyle(
                    fontSize: screenUtil.setSp(Dimens.h2_size),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, String content, Color color) {
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
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, Screens.MAIN.toString(), (route) => false);
        },
      ),
    );
  }
}
