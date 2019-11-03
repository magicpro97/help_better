import 'dart:async';

import 'package:better_help/common/auth0/auth.dart';
import 'package:better_help/common/route/route.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  @override
  MainState get initialState => InitialMainState();

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    if (event is CheckingUserSessionEvent) {
      final currentUser = await Auth.currentUser();
      if (currentUser == null) {
        final newUser = await Auth.signIn();
        if (newUser == null) {
          goToWelcomeScreen(event.context);
        }
      }
    }
  }
}
