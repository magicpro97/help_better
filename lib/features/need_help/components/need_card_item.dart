import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/utils/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NeedCardItem extends StatelessWidget {
  final User user;
  final Function onTap;

  const NeedCardItem({Key key, @required this.user, this.onTap})
      : assert(user != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.instance;

    final titleTextStyle = Theme.of(context)
        .primaryTextTheme
        .caption
        .copyWith(fontSize: screenUtil.setSp(Dimens.h2_size));

    final descriptionTextStyle =
        Theme.of(context).primaryTextTheme.body1.copyWith(
              fontSize: screenUtil.setSp(Dimens.body1_size),
            );

    return Container(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: userNeedMapColor[user.needs],
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              user.displayName,
              style: titleTextStyle,
            ),
            Text(
              getHourAndMinute(
                user.updated ?? user.created,
              ),
              style: descriptionTextStyle,
            ),
          ],
        ),
        subtitle: Text(
          userNeedsDescription(context, user.needs) ?? '',
          style: descriptionTextStyle,
        ),
        onTap: onTap,
      ),
    );
  }
}
