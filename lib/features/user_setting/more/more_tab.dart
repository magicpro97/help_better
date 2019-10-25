import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/common/utils/time_utils.dart';
import 'package:better_help/features/user_setting/more/bloc/bloc.dart';
import 'package:better_help/features/user_setting/more/setting_option_button.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreTab extends StatefulWidget {
  @override
  _MoreTabState createState() => _MoreTabState();
}

class _MoreTabState extends State<MoreTab> {
  final moreBloc = MoreBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    moreBloc.close();
    super.dispose();
  }

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
              StreamBuilder<User>(
                stream: moreBloc.userStream,
                builder: (context, snapshot) =>
                    ScreenTitle(
                      title: S.of(context).more_greeting(
                          getAHaftDayName(context),
                          snapshot.hasData
                              ? snapshot.data.displayName
                              : S
                              .of(context)
                              .you),
                    ),
              ),
              SizedBox(
                height: screenUtil.setHeight(Dimens.large_space),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    SettingOptionButton(
                      name: S.of(context).more_change_nickname,
                      onPress: () => moreBloc.add(ChangeNicknameEvent(context)),
                    ),
                    SettingOptionButton(
                      name: S.of(context).more_change_status,
                      onPress: () =>
                          moreBloc.add(ChangeUserNeedsEvent(context)),
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
                      onPress: () => moreBloc.add(SignOutEvent(context)),
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
