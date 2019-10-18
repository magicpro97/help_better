import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/ui/screen_subtitle.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: Dimens.horizontal_space),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: Dimens.top_space,
            ),
            Center(
              child: ScreenTitle(
                title: S.of(context).user_type_title,
              ),
            ),
            SizedBox(
              height: Dimens.normal_space,
            ),
            _buildOptionButton(
                S.of(context).option_teenage, Colors.yellow[700]),
            _buildOptionButton(S.of(context).option_love, Colors.pink),
            _buildOptionButton(S.of(context).option_family, Colors.blue),
            _buildOptionButton(
                S.of(context).option_go_a_head, Colors.greenAccent),
            Divider(
              height: 1.0,
              thickness: 3.0,
            ),
            SizedBox(
              height: Dimens.normal_space,
            ),
            ScreenSubtitle(
              subtitle: S.of(context).user_type_subtitle,
            ),
            SizedBox(
              height: Dimens.normal_space,
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
                    fontSize: Dimens.h2_size,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String content, Color color) {
    final contentStyle = TextStyle(
      fontSize: Dimens.h2_size,
      color: Colors.white,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: Dimens.normal_space),
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        elevation: Dimens.elevation,
        child: Padding(
          padding: const EdgeInsets.all(29.0),
          child: Text(
            content,
            textAlign: TextAlign.center,
            style: contentStyle,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
