import 'package:better_help/common/themes.dart';
import 'package:better_help/features/app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => {Provider.debugCheckInvalidValueType = null, runApp(MyApp())};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: Theme(
        data: theme,
        child: App(),
      ),
      providers: [
      ],
    );
  }
}
