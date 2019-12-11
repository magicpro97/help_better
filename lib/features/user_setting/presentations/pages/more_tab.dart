import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/common/utils/time_utils.dart';
import 'package:better_help/features/user_setting/presentations/bloc/bloc.dart';
import 'package:better_help/features/user_setting/presentations/widgets/setting_option_button.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../injection_container.dart';

class MoreTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserSettingBloc>(context).add(ReloadCurrentUser());
  
    return BlocProvider<UserSettingBloc>(
      create: (_) => sl(),
      child: SafeArea(
        child: Container(
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();

    return BlocBuilder<UserSettingBloc, UserSettingState>(
      bloc: BlocProvider.of<UserSettingBloc>(context),
      builder: (context, state) =>
          SingleChildScrollView(
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
                        state is UserLoaded
                            ? state.user.displayName
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
          ),
    );
  }

  Widget _optionList(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();

    return Container(
      child: Column(
        children: <Widget>[
          SettingOptionButton(
            name: S.of(context).more_change_nickname,
            onPress: () =>
                BlocProvider.of<UserSettingBloc>(context)
                .add(PressOnChangeNicknameButton(context: context)),
          ),
          SettingOptionButton(
            name: S.of(context).more_change_status,
            onPress: () =>
                BlocProvider.of<UserSettingBloc>(context)
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
            onPress: () =>
                BlocProvider.of<UserSettingBloc>(context)
                    .add(PressOnSignOutButton(context: context)),
          ),
        ],
      ),
    );
  }
}
