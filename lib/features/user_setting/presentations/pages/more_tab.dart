import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/common/utils/time_utils.dart';
import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/features/user_setting/presentations/bloc/bloc.dart';
import 'package:better_help/features/user_setting/presentations/widgets/setting_option_button.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreTab extends StatefulWidget {
  @override
  _MoreTabState createState() => _MoreTabState();
}

class _MoreTabState extends State<MoreTab> {
  UserSettingBloc _userSettingBloc;

  @override
  void initState() {
    _userSettingBloc = BlocProvider.of<UserSettingBloc>(context);
    _userSettingBloc.add(InitCurrentUserStream());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserSettingBloc, UserSettingState>(
      bloc: _userSettingBloc,
      listener: (_, state) {},
      condition: (prev, next) {
        return prev != next;
      },
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
      bloc: _userSettingBloc,
      builder: (context, state) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: screenUtil.setHeight(Dimens.top_space),
            ),
            Center(
              child: state is UserLoaded
                  ? StreamBuilder<User>(
                      stream: state.userStream,
                      builder: (context, snapshot) {
                        return ScreenTitle(
                            title: S.of(context).more_greeting(
                                  getAHaftDayName(context),
                                  snapshot.data?.displayName ??
                                      S.of(context).you,
                                ));
                      },
                    )
                  : Container(),
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
            onPress: () => BlocProvider.of<UserSettingBloc>(context)
                .add(PressOnChangeNicknameButton(context: context)),
          ),
          SettingOptionButton(
            name: S.of(context).more_change_status,
            onPress: () => BlocProvider.of<UserSettingBloc>(context)
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
            onPress: () => BlocProvider.of<UserSettingBloc>(context)
                .add(PressOnSignOutButton(context: context)),
          ),
        ],
      ),
    );
  }
}
