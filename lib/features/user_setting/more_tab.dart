import 'package:better_help/common/auth0/auth.dart';
import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/screens.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/features/user_setting/setting_option_button.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();

    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: screenUtil.setHeight(Dimens.top_space),
              ),
              ScreenTitle(
                title: S.of(context).more_greeting('Buổi tối', 'Huongali'),
              ),
              SizedBox(
                height: screenUtil.setHeight(Dimens.large_space),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    SettingOptionButton(
                      name: S.of(context).more_change_nickname,
                      onPress: () => Navigator.pushNamed(
                          context, Screens.NICKNAME.toString()),
                    ),
                    SettingOptionButton(
                      name: S.of(context).more_change_status,
                      onPress: () => Navigator.pushNamed(
                          context, Screens.USER_TYPE.toString()),
                    ),
                    SizedBox(
                      height: screenUtil.setHeight(Dimens.xlarge_space),
                    ),
                    SettingOptionButton(
                      name: S.of(context).more_register_volunteer,
                    ),
                    SizedBox(
                      height: screenUtil.setHeight(Dimens.xlarge_space),
                    ),
                    SettingOptionButton(
                      name: S.of(context).more_share_app,
                    ),
                    SizedBox(
                      height: screenUtil.setHeight(Dimens.xlarge_space),
                    ),
                    SettingOptionButton(
                      name: S
                          .of(context)
                          .more_sign_out,
                      onPress: () {
                        Auth.signOut();
                        Navigator.pushNamed(
                            context, Screens.WELCOME.toString());
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
