import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/common/utils/time_utils.dart';
import 'package:better_help/core/usecase/usecase.dart';
import 'package:better_help/features/user_setting/domain/entities/user.dart';
import 'package:better_help/features/user_setting/presentations/bloc/bloc.dart';
import 'package:better_help/features/user_setting/presentations/widgets/setting_option_button.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: _buildBody(context),
      ),
    );
  }

  FutureBuilder<User> _buildBody(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();
    final userSettingBloc = BlocProvider.of<UserSettingBloc>(context);
  
    return FutureBuilder<User>(
        future: userSettingBloc.getCurrentUser(NoParams()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong. ${snapshot.error}'),
            );
          }
        
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: screenUtil.setHeight(Dimens.top_space),
                ),
                Center(
                  child: ScreenTitle(
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
                _optionList(context),
              ],
            ),
          );
        });
  }

  Widget _optionList(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();
    final userSettingBloc = BlocProvider.of<UserSettingBloc>(context);

    return Container(
      child: Column(
        children: <Widget>[
          SettingOptionButton(
            name: S.of(context).more_change_nickname,
            onPress: () =>
                userSettingBloc
                    .add(PressOnChangeNicknameButton(context: context)),
          ),
          SettingOptionButton(
            name: S.of(context).more_change_status,
            onPress: () =>
                userSettingBloc
                    .add(PressOnChangeUserNeedsButton(context: context)),
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
            name: S.of(context).more_sign_out,
            onPress: () => userSettingBloc.add(SignOut(context: context)),
          ),
        ],
      ),
    );
  }
}
