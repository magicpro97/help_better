import 'package:better_help/common/themes.dart';
import 'package:better_help/features/app/app.dart';
import 'package:better_help/features/app/bloc/app_bloc.dart';
import 'package:better_help/features/user_setting/presentations/bloc/user_setting_bloc.dart';
import 'package:better_help/injection_container.dart' as di;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        child: Theme(
          data: theme,
          child: App(),
        ),
        providers: [
          BlocProvider(
            create: (_) => di.sl<AppBloc>(),
          ),
          BlocProvider(
            create: (context) =>
                UserSettingBloc(
                  updateUser: di.sl(),
                  getCurrentUser: di.sl(),
                ),
          ),
        ]);
  }
}
