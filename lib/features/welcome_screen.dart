import 'package:better_help/common/assets.dart';
import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/screens.dart';
import 'package:better_help/common/ui/screen_caption.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();

    return CupertinoPageScaffold(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: kToolbarHeight,
            ),
            Center(
              child: ScreenTitle(
                title: S.of(context).share_with_me,
              ),
            ),
            SizedBox(
              height: screenUtil.setHeight(Dimens.normal_space),
            ),
            Center(
              child: ScreenCaption(caption: S.of(context).slogan),
            ),
            SizedBox(
              height: screenUtil.setHeight(Dimens.normal_space),
            ),
            Image.asset(Assets.help_someone_colors),
            SizedBox(
              height: screenUtil.setHeight(Dimens.large_space),
            ),
            CupertinoButton(
                child: Text(S.of(context).continue_with_google),
                color: Colors.pink,
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    Screens.NICKNAME.toString(),
                    (route) =>
                        false) /*showDialog(
                context: context,
                builder: (context) => HBAlertDialog(
                  title: S.of(context).dialog_continue_with_google_title,
                  content: S.of(context).dialog_continue_with_google_content,
                  negativeText: S.of(context).cancel_action,
                  positiveText: S.of(context).continue_action,
                ),
              ),*/
                ),
          ],
        ),
      ),
    );
  }
}
