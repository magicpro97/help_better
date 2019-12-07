import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/ui/screen_caption.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/features/user_setting/domain/entities/user.dart';
import 'package:better_help/features/user_setting/presentations/bloc/bloc.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/needs_button.dart';

class UserNeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userSettingBloc = BlocProvider.of<UserSettingBloc>(context);
    userSettingBloc.add(CheckUserType());
    final screenUtil = ScreenUtil.getInstance();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(),
      child: SafeArea(
        child: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            child: BlocBuilder<UserSettingBloc, UserSettingState>(
              bloc: userSettingBloc,
              builder: (context, state) => Column(
                children: <Widget>[
                  SizedBox(
                    height: screenUtil.setHeight(Dimens.top_space),
                  ),
                  Center(
                    child: ScreenTitle(
                      title: S.of(context).user_type_title,
                    ),
                  ),
                  SizedBox(
                    height: screenUtil.setHeight(Dimens.large_space),
                  ),
                  NeedsButton(
                    content: S.of(context).option_teenage,
                    color: userNeedMapColor[UserNeeds.TEENAGE],
                    onPress: () => userSettingBloc.add(PressOnNeedOption(
                        context: context, userNeeds: UserNeeds.TEENAGE)),
                  ),
                  NeedsButton(
                    content: S.of(context).option_love,
                    color: userNeedMapColor[UserNeeds.LOVE],
                    onPress: () => userSettingBloc.add(PressOnNeedOption(
                        context: context, userNeeds: UserNeeds.LOVE)),
                  ),
                  NeedsButton(
                    content: S.of(context).option_family,
                    color: userNeedMapColor[UserNeeds.FAMILY],
                    onPress: () => userSettingBloc.add(PressOnNeedOption(
                        context: context, userNeeds: UserNeeds.FAMILY)),
                  ),
                  NeedsButton(
                    content: S.of(context).option_go_a_head,
                    color: userNeedMapColor[UserNeeds.GO_AHEAD],
                    onPress: () => userSettingBloc.add(PressOnNeedOption(
                        context: context, userNeeds: UserNeeds.GO_AHEAD)),
                  ),
                  SizedBox(
                    height: screenUtil.setHeight(Dimens.large_space),
                  ),
                  Divider(
                    height: 1.0,
                    thickness: 3.0,
                    indent: screenUtil.setHeight(Dimens.horizontal_space),
                    endIndent: screenUtil.setHeight(Dimens.horizontal_space),
                  ),
                  state is AlreadyVolunteer
                      ? Container()
                      : joinVolunteerWidgets(screenUtil, context, userSettingBloc),
                  SizedBox(
                    height: screenUtil.setHeight(Dimens.normal_space),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget joinVolunteerWidgets(ScreenUtil screenUtil, BuildContext context, UserSettingBloc userSettingBloc) =>
      Column(
        children: <Widget>[
          SizedBox(
            height: screenUtil.setHeight(Dimens.normal_space),
          ),
          ScreenCaption(
            caption: S.of(context).user_type_subtitle,
          ),
          SizedBox(
            height: screenUtil.setHeight(Dimens.normal_space),
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: Dimens.elevation,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                S.of(context).user_type_volunteer_register,
                style: TextStyle(
                  fontSize: screenUtil.setSp(Dimens.h2_size),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            onPressed: () =>
                userSettingBloc.add(JoinVolunteer(context: context)),
          ),
        ],
      );
}

final userNeedMapColor = {
  UserNeeds.TEENAGE: Colors.blue,
  UserNeeds.FAMILY: Colors.yellow[700],
  UserNeeds.LOVE: Colors.pink,
  UserNeeds.GO_AHEAD: Colors.greenAccent,
};
