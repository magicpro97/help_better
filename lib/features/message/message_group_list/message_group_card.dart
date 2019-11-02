import 'dart:developer';

import 'package:better_help/common/data/dao/message_dao.dart';
import 'package:better_help/common/data/models/message.dart';
import 'package:better_help/common/data/models/message_group.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/data/tranformer/message.dart';
import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/route/route.dart';
import 'package:better_help/common/utils/time_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageGroupCard extends StatelessWidget {
  final MessageGroup messageGroup;
  final User currentUser;

  const MessageGroupCard({
    Key key,
    @required this.messageGroup,
    @required this.currentUser,
  })
      : assert(messageGroup != null),
        assert(currentUser != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.instance;

    final unReadTextStyle = Theme
        .of(context)
        .primaryTextTheme
        .caption
        .copyWith(fontSize: screenUtil.setSp(Dimens.h2_size));
    final readTextStyle = Theme
        .of(context)
        .primaryTextTheme
        .body1
        .copyWith(fontSize: screenUtil.setSp(Dimens.h2_size));

    return StreamBuilder<Message>(
        stream: MessageDao.messageListStream(messageGroup.id)
            .transform(toLatestMessage),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          if (snapshot.hasError) {
            log(snapshot.error);
          }

          final latestMessage = snapshot.data;
          final latestMessageTextStyle =
          latestMessage.status != MessageStatus.READ &&
              currentUser.id != latestMessage.userId
              ? unReadTextStyle
              : readTextStyle;

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                messageGroup.imageUrl,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  messageGroup.displayName,
                  style: latestMessageTextStyle,
                ),
                Text(
                  getHourAndMinute(
                    latestMessage.updated ?? latestMessage.created,
                  ),
                  style: latestMessageTextStyle,
                ),
              ],
            ),
            subtitle: Text(
              latestMessage.content,
              style: latestMessageTextStyle,
            ),
            onTap: () => goToMessageScreen(context, messageGroup, currentUser),
          );
        });
  }
}
