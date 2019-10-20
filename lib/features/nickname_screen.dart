import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/screens.dart';
import 'package:better_help/common/ui/screen_caption.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NicknameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nickNameController = TextEditingController();

    return CupertinoPageScaffold(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: kToolbarHeight,
            ),
            Center(
              child: ScreenTitle(
                title: S.of(context).how_could_i_call_you,
              ),
            ),
            SizedBox(
              height: Dimens.normal_space,
            ),
            Center(
              child: ScreenCaption(
                subtitle: S.of(context).don_t_need_your_real_name,
              ),
            ),
            SizedBox(
              height: Dimens.normal_space * 2,
            ),
            CupertinoTextField(
              placeholder: S.of(context).type_nick_name,
              controller: nickNameController,
              style: Theme.of(context).primaryTextTheme.body1,
              onSubmitted: (nickname) => Navigator.pushNamedAndRemoveUntil(
                  context, Screens.USER_TYPE.toString(), (route) => false),
            )
          ],
        ),
      ),
    );
  }
}
