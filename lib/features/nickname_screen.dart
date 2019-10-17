import 'package:better_help/common/ui/screen_subtitle.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/common/ui/ui_utils.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NicknameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nickNameController = TextEditingController();

    return CupertinoPageScaffold(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: UIUtils.topSpaceDimen,
            ),
            Center(
              child: ScreenTitle(
                title: S.of(context).how_could_i_call_you,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: ScreenSubtitle(
                subtitle: S.of(context).don_t_need_your_real_name,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            CupertinoTextField(
              placeholder: S.of(context).type_nick_name,
              controller: nickNameController,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
