import 'dart:developer';

import 'package:better_help/common/assets.dart';
import 'package:better_help/common/data/dao/user_dao.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/data/tranformer/user.dart';
import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/ui/screen_caption.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/features/need_help/bloc/bloc.dart';
import 'package:better_help/features/need_help/components/need_card_item.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NeedHelpTab extends StatefulWidget {
    final User currentUser;
    final List<User> friends;

    const NeedHelpTab(
        {Key key, @required this.currentUser, @required this.friends})
        : assert(currentUser != null),
            assert(friends != null),
            super(key: key);

    @override
    _NeedHelpTabState createState() => _NeedHelpTabState();
}

class _NeedHelpTabState extends State<NeedHelpTab> {
    final needHelpBloc = NeedHelpBloc();

    @override
    void dispose() {
        super.dispose();
        needHelpBloc.close();
    }

    @override
    Widget build(BuildContext context) {
        final currentUser = widget.currentUser;

        return SafeArea(
            child: StreamBuilder<User>(
                stream: UserDao.userStream(currentUser.id),
                builder: (context, snapshot) {
                    if (snapshot.hasError || !snapshot.hasData) {
                        log(snapshot.data.toString());
                        return Center(
                            child: Text("Lỗi"),
                        );
                    }
                    final user = snapshot.data;

                    return user.types.contains(UserType.VOLUNTEER)
                        ? _buildHelpList()
                        : _buildInvitation();
                },
            ),
        );
    }

    Widget _buildInvitation() {
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
                        onPressed: () =>
                            needHelpBloc.add(JoinVolunteerEvent(user: widget.currentUser)),
                    ),
                ],
            ),
        );
    }

    Widget _buildHelpList() {
        final screenUtil = ScreenUtil.instance;
        final friends = widget.friends;

        return Scaffold(
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
                                stream: needHelpBloc.userListStream.transform(
                                    toNeedCardItemList(
                                        context: context,
                                        needHelpBloc: needHelpBloc,
                                        otherUser: friends)),
                                builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                        return Container();
                                    }

                                    if (snapshot.hasError) {
                                        log(snapshot.data.toString());
                                    }

                                    final currentUser = widget.currentUser;
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
            ));
    }
}
