import 'dart:async';
import 'dart:developer';

import 'package:better_help/common/auth0/auth.dart';
import 'package:better_help/common/route/route.dart';
import 'package:better_help/features/main/main_screen.dart';
import 'package:bloc/bloc.dart';

import 'bloc.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  @override
  WelcomeState get initialState => CheckSignInState();

  @override
  Stream<WelcomeState> mapEventToState(
    WelcomeEvent event,
  ) async* {
    log(event.toString());
    if (event is SignInEvent) {
      final user = await Auth.signIn();
      if (user != null) {
        goToMainScreen(event.context, deleteAllLastScreen: true);
        yield SignedState();
      } else {
        if (await Auth.isNewUser()) {
          Auth.createUser();
          goToNicknameScreen(event.context, deleteAllLastScreen: true);
          yield SignedState();
        } else {
          yield SignInFailState();
        }
      }
    } else if (event is CheckSignInStateEvent) {
      final user = await Auth.currentUser();
      if (user != null) {
        yield SignedState();
        goToMainScreen(event.context,
            deleteAllLastScreen: true, arguments: MainArgument(user: user));
      }
    }
  }
}
