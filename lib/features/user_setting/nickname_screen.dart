import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/screens.dart';
import 'package:better_help/common/ui/screen_caption.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NicknameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();
    final nickNameController = TextEditingController();
    final textNicknameStyle = Theme.of(context).primaryTextTheme.body1;

    return CupertinoPageScaffold(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: screenUtil.setWidth(Dimens.horizontal_space)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: ScreenTitle(
                title: S.of(context).how_could_i_call_you,
              ),
            ),
            SizedBox(
              height: screenUtil.setHeight(Dimens.normal_space),
            ),
            Center(
              child: ScreenCaption(
                caption: S.of(context).don_t_need_your_real_name,
              ),
            ),
            SizedBox(
              height: screenUtil.setHeight(Dimens.large_space),
            ),
            CupertinoTextField(
              placeholder: S.of(context).type_nick_name,
              controller: nickNameController,
              style: textNicknameStyle.copyWith(
                  fontSize: screenUtil.setSp(Dimens.body1_size)),
              onSubmitted: (nickname) => Navigator.pushNamedAndRemoveUntil(
                  context, Screens.USER_TYPE.toString(), (route) => false),
            )
          ],
        ),
      ),
    );
  }
}
