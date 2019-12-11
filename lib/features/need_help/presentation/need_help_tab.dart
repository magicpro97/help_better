import 'dart:developer';

import 'package:better_help/common/assets.dart';
import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/ui/screen_caption.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/core/data/tranformer/user.dart';
import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/features/need_help/presentation/bloc/bloc.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../injection_container.dart';
import 'widgets/need_card_item.dart';

class NeedHelpTab extends StatelessWidget {
  final User currentUser;
  final List<User> friends;

  const NeedHelpTab(
      {Key key, @required this.currentUser, @required this.friends})
      : assert(currentUser != null),
        assert(friends != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: currentUser.types.contains(UserType.VOLUNTEER)
            ? _buildHelpList(context)
            : _buildInvitation(context));
  }

  Widget _buildInvitation(BuildContext context) {
    final screenUtil = ScreenUtil.instance;

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: screenUtil.setHeight(Dimens.top_space),
          ),
          ScreenTitle(
            title: S.of(context).need_help_title,
          ),
          SizedBox(
            height: screenUtil.setHeight(Dimens.normal_space),
          ),
          ScreenCaption(
            caption: S.of(context).need_help_caption,
          ),
          SizedBox(
            height: screenUtil.setHeight(Dimens.normal_space),
          ),
          Image.asset(Assets.help_someone_colors),
          SizedBox(
            height: screenUtil.setHeight(Dimens.large_space),
          ),
          CupertinoButton(
            color: Colors.tealAccent[400],
            child: Text(S.of(context).need_help_action),
            onPressed: () => BlocProvider.of<NeedHelpBloc>(context)
                .add(JoinVolunteerEvent(user: currentUser)),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpList(BuildContext context) {
    final screenUtil = ScreenUtil.instance;

    return BlocProvider<NeedHelpBloc>(
      create: (_) => sl(),
      child: Scaffold(
          body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: screenUtil.setHeight(Dimens.top_space),
            ),
            ScreenTitle(
              title: S.of(context).need_help_list_title,
            ),
            Expanded(
              child: StreamBuilder<List<NeedCardItem>>(
                  stream: BlocProvider.of<NeedHelpBloc>(context)
                      .userListStream
                      .transform(toNeedCardItemList(
                          context: context,
                          needHelpBloc: BlocProvider.of<NeedHelpBloc>(context),
                          otherUser: friends)),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }

                    if (snapshot.hasError) {
                      log(snapshot.data.toString());
                    }

                    final items = snapshot.data;
                    items.removeWhere((item) =>
                        item.user.id == currentUser.id ||
                        item.user.needs == null);

                    return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) => items[index]);
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
