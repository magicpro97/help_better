import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();

    return Container(
      child: ListTile(
        title: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(screenUtil.setHeight(20.0)),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Text(
                'Hello',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
