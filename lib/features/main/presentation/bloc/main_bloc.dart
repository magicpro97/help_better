import 'dart:async';

import 'package:better_help/core/domain/usecase/get_current_user.dart';
import 'package:better_help/core/domain/usecase/get_user_friend.dart';
import 'package:better_help/core/domain/usecase/get_user_stream.dart';
import 'package:better_help/features/authentication/domain/use_cases/sign_in.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetCurrentUser getCurrentUser;
  final SignIn signIn;
  final GetUserStream getUserStream;
  final GetUserFriends getUserFriends;

  MainBloc({
    @required this.getCurrentUser,
    @required this.signIn,
    @required this.getUserStream,
    @required this.getUserFriends,
  });

  @override
  MainState get initialState => InitialMainState();

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    /* if (event is CheckingUserSessionEvent) {
      final currentUser = await getCurrentUser();
    }
    //final newUser = await signIn(NoParams());
    
    if (currentUser == null) {
    final newUser = await signIn();
    if (newUser == null) {
    goToWelcomeScreen(event.context);
    }
    }*/
  }
}
