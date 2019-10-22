import 'package:better_help/common/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionButton extends StatelessWidget {
  final String name;
  final Function onPress;

  const OptionButton({Key key, @required this.name, this.onPress})
      : assert(name != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();
    final textOptionStyle = Theme.of(context).primaryTextTheme.body1;

    return RaisedButton(
        elevation: 0.0,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: screenUtil.setHeight(40.0)),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    name,
                    style: textOptionStyle.copyWith(
                        fontSize: screenUtil.setSp(Dimens.body1_size)),
                  )),
                  Icon(CupertinoIcons.forward),
                ],
              ),
            ),
            Divider(
              height: 1.0,
              thickness: 1.0,
            ),
          ],
        ),
        onPressed: onPress);
  }
}
