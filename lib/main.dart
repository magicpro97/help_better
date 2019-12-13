import 'package:better_help/common/themes.dart';
import 'package:better_help/features/app/presentations/app.dart';
import 'package:better_help/features/main/presentation/bloc/main_bloc.dart';
import 'package:better_help/features/user_setting/presentations/bloc/user_setting_bloc.dart';
import 'package:better_help/injection_container.dart' as di;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/app/presentations/bloc/app_bloc.dart';
import 'features/authentication/presentations/bloc/welcome_bloc.dart';
import 'features/message/presentation/bloc/message_bloc.dart';
import 'features/need_help/presentation/bloc/need_help_bloc.dart';

void main() {
  di.init();
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
        BlocProvider<AppBloc>(
          create: (_) => di.sl<AppBloc>(),
        ),
        BlocProvider<UserSettingBloc>(
          create: (_) => di.sl<UserSettingBloc>(),
        ),
        BlocProvider<WelcomeBloc>(
          create: (_) => di.sl<WelcomeBloc>(),
        ),
        BlocProvider<MainBloc>(
          create: (_) => di.sl<MainBloc>(),
        ),
        BlocProvider<MessageBloc>(
          create: (_) => di.sl<MessageBloc>(),
        ),
        BlocProvider<NeedHelpBloc>(
          create: (_) => di.sl<NeedHelpBloc>(),
        ),
      ],
    );
  }
}
