import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:better_help/common/route/route.dart';
import 'package:better_help/core/domain/usecase/add_user_device_token.dart';
import 'package:better_help/core/domain/usecase/create_user.dart';
import 'package:better_help/core/domain/usecase/get_current_user.dart';
import 'package:better_help/features/authentication/domain/use_cases/sign_in.dart';
import 'package:better_help/features/main/presentation/pages/main_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';

import 'bloc.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final SignIn signIn;
  final CreateUser createUser;
  final GetCurrentUser getCurrentUser;
  final AddUserDeviceToken addUserDeviceToken;
  final FirebaseMessaging firebaseMessaging;
  bool _firstTimeSignIn = true;

  WelcomeBloc(
      {@required this.signIn,
      @required this.createUser,
      @required this.getCurrentUser,
      @required this.addUserDeviceToken,
      @required this.firebaseMessaging});

  @override
  WelcomeState get initialState => CheckSignInState();

  @override
  Stream<WelcomeState> mapEventToState(
    WelcomeEvent event,
  ) async* {
    log(event.toString());
    if (event is SignInEvent) {
      try {
        final user = await signIn();
        _addUserDeviceToken();
        if (user != null) {
          goToMainScreen(event.context,
              deleteAllLastScreen: true, arguments: MainArgument(user: user));
        } else {
          createUser();
          goToNicknameScreen(event.context, deleteAllLastScreen: true);
        }
        yield SignedState();
      } on Exception {
        yield SignInFailState();
      }
      await _addUserDeviceToken();
    } else if (event is CheckSignInStateEvent) {
      yield CheckSignInState();
      final user = await getCurrentUser();
      if (user != null && _firstTimeSignIn) {
        _firstTimeSignIn = false;
        goToMainScreen(event.context,
            deleteAllLastScreen: true, arguments: MainArgument(user: user));
        yield SignedState();
      }
      yield SignInCheckedState();
    }
  }

  Future _addUserDeviceToken() async {
    if (Platform.isIOS) {
      firebaseMessaging.requestNotificationPermissions();
      firebaseMessaging.onIosSettingsRegistered.listen((data) async {
        addUserDeviceToken(await firebaseMessaging.getToken());
      });
    } else {
      addUserDeviceToken(await firebaseMessaging.getToken());
    }
  }
}
