import 'package:better_help/common/assets.dart';
import 'package:better_help/common/screens.dart';
import 'package:better_help/common/ui/screen_subtitle.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/common/ui/ui_utils.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: UIUtils.topSpaceDimen,
            ),
            Center(
              child: ScreenTitle(
                title: S.of(context).share_with_me,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: ScreenSubtitle(subtitle: S.of(context).slogan),
            ),
            SizedBox(
              height: 24.0,
            ),
            Image.asset(Assets.help_someone_colors),
            SizedBox(
              height: 89.0,
            ),
            CupertinoButton(
                child: Text(S
                    .of(context)
                    .continue_with_google),
                color: Colors.pink,
                onPressed: () =>
                    Navigator.pushNamedAndRemoveUntil(
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
