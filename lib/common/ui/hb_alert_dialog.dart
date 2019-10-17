import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HBAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String negativeText;
  final String positiveText;

  const HBAlertDialog({
    Key key,
    @required this.title,
    @required this.content,
    @required this.negativeText,
    @required this.positiveText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final negativeButtonTextStyle = TextStyle(color: Colors.blue);
    final positiveButtonTextStyle =
        TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold);

    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
          child: Text(
            negativeText,
            style: negativeButtonTextStyle,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text(
            positiveText,
            style: positiveButtonTextStyle,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
