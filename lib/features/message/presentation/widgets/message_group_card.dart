import 'dart:developer';

import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/route/route.dart';
import 'package:better_help/common/utils/time_utils.dart';
import 'package:better_help/core/data/tranformer/message.dart';
import 'package:better_help/core/domain/entities/message_group.dart';
import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/features/message/domain/entities/message.dart';
import 'package:better_help/features/message/presentation/bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageGroupCard extends StatelessWidget {
  final MessageGroup messageGroup;
  final User currentUser;
  final List<User> otherUser;

  const MessageGroupCard({
    Key key,
    @required this.messageGroup,
    @required this.currentUser,
    @required this.otherUser,
  })  : assert(messageGroup != null),
        assert(currentUser != null),
        assert(otherUser != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.instance;
    final unReadTextStyle = Theme.of(context)
        .primaryTextTheme
        .caption
        .copyWith(fontSize: screenUtil.setSp(Dimens.h2_size));
    final readTextStyle = Theme.of(context)
        .primaryTextTheme
        .body1
        .copyWith(fontSize: screenUtil.setSp(Dimens.h2_size));

    return StreamBuilder<Message>(
        stream: BlocProvider.of<MessageBloc>(context)
            .getMessageListStream(messageGroup.id)
            .transform(toLatestMessage),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          if (snapshot.hasError) {
            log(snapshot.error);
          }

          final latestMessage = snapshot.data;
          final latestMessageTextStyle = latestMessage.isSeenMessage() &&
                  currentUser.id != latestMessage.userId
              ? readTextStyle
              : unReadTextStyle;

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                messageGroup.imageUrl ?? otherUser.first.photoUrl,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  messageGroup.displayName ?? displayName(otherUser),
                  style: latestMessageTextStyle,
                ),
                Text(
                  getHourAndMinute(
                    latestMessage.updated ?? latestMessage.created,
                  ),
                  style: latestMessageTextStyle.copyWith(
                    fontSize: screenUtil.setSp(Dimens.body1_size),
                  ),
                ),
              ],
            ),
            subtitle: Text(
              latestMessage.content,
              style: latestMessageTextStyle.copyWith(
                fontSize: screenUtil.setSp(Dimens.body1_size),
              ),
            ),
            onTap: () => goToMessageScreen(
                context, messageGroup, currentUser, otherUser),
          );
        });
  }
}

String displayName(List<User> users) {
  if (users.length > 1) {
    var name = "";
    users.forEach((user) => name = name + "${user.displayName}, ");
    final newName = name.substring(0, name.lastIndexOf(', ')).trim();
    return newName;
  }
  return users.first.displayName;
}
