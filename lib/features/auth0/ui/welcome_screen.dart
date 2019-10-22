import 'package:better_help/common/assets.dart';
import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/screens.dart';
import 'package:better_help/common/ui/screen_caption.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/bloc.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final welcomeBloc = BlocProvider.of<WelcomeBloc>(context);
    final screenUtil = ScreenUtil.getInstance();

    return BlocBuilder<WelcomeBloc, WelcomeState>(
      bloc: welcomeBloc,
      builder: (context, state) {
        welcomeBloc.add(CheckSignInStateEvent());
        if (state is SignedState) {
          Navigator.pushNamedAndRemoveUntil(
              context, Screens.MAIN.toString(), (route) => false);
          welcomeBloc.close();
        }
        return CupertinoPageScaffold(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: ScreenTitle(
                    title: S.of(context).share_with_me,
                  ),
                ),
                SizedBox(
                  height: screenUtil.setHeight(Dimens.normal_space),
                ),
                Center(
                  child: ScreenCaption(caption: S.of(context).slogan),
                ),
                SizedBox(
                  height: screenUtil.setHeight(Dimens.normal_space),
                ),
                Image.asset(Assets.help_someone_colors),
                SizedBox(
                  height: screenUtil.setHeight(Dimens.large_space),
                ),
                CupertinoButton(
                  child: Text(S.of(context).continue_with_google),
                  color: Colors.pink,
                  onPressed: () {
                    welcomeBloc.add(SignInEvent());
                    if (state is NewUserState) {
                      Navigator.pushNamedAndRemoveUntil(context,
                          Screens.NICKNAME.toString(), (route) => false);
                    } else {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Screens.MAIN.toString(), (route) => false);
                    }
                    welcomeBloc.close();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
