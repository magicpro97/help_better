import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/ui/screen_caption.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/features/user_setting/user_needs/bloc/user_needs_bloc.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../user_needs/bloc/bloc.dart';
import '../../user_needs/bloc/user_needs_event.dart';
import '../widgets/needs_button.dart';

class UserNeedsScreen extends StatefulWidget {
  @override
  _UserNeedsScreenState createState() => _UserNeedsScreenState();
}

class _UserNeedsScreenState extends State<UserNeedsScreen> {
  final userNeedBloc = UserNeedsBloc();

  @override
  void dispose() {
    super.dispose();
    userNeedBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: screenUtil.setHeight(Dimens.top_space),
                ),
                Center(
                  child: ScreenTitle(
                    title: S
                        .of(context)
                        .user_type_title,
                  ),
                ),
                SizedBox(
                  height: screenUtil.setHeight(Dimens.large_space),
                ),
                NeedsButton(
                  content: S
                      .of(context)
                      .option_teenage,
                  color: userNeedMapColor[UserNeeds.TEENAGE],
                  onPress: () =>
                      userNeedBloc.add(SelectOptionTeenageEvent(context)),
                ),
                NeedsButton(
                  content: S
                      .of(context)
                      .option_love,
                  color: userNeedMapColor[UserNeeds.LOVE],
                  onPress: () =>
                      userNeedBloc.add(SelectOptionLoveEvent(context)),
                ),
                NeedsButton(
                  content: S
                      .of(context)
                      .option_family,
                  color: userNeedMapColor[UserNeeds.FAMILY],
                  onPress: () =>
                      userNeedBloc.add(SelectOptionFamilyEvent(context)),
                ),
                NeedsButton(
                  content: S
                      .of(context)
                      .option_go_a_head,
                  color: userNeedMapColor[UserNeeds.GO_AHEAD],
                  onPress: () =>
                      userNeedBloc.add(SelectOptionGoAheadEvent(context)),
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
                SizedBox(
                  height: screenUtil.setHeight(Dimens.normal_space),
                ),
                ScreenCaption(
                  caption: S
                      .of(context)
                      .user_type_subtitle,
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
                      S
                          .of(context)
                          .user_type_volunteer_register,
                      style: TextStyle(
                        fontSize: screenUtil.setSp(Dimens.h2_size),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onPressed: () =>
                      userNeedBloc.add(JoinVolunteerEvent(context)),
                ),
                SizedBox(
                  height: screenUtil.setHeight(Dimens.normal_space),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
