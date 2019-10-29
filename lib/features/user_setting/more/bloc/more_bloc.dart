import 'dart:async';

import 'package:better_help/common/auth0/auth.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/route/route.dart';
import 'package:better_help/features/app/bloc/app_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import './bloc.dart';

class MoreBloc extends Bloc<MoreEvent, MoreState> {
  final AppBloc appBloc;

  final _userController = BehaviorSubject<User>();

  User get user => _userController.value;

  Stream<User> get userStream => _userController.stream;

  Function get changeUser => _userController.add;

  StreamSubscription _firebaseUserSubscription;

  MoreBloc({@required this.appBloc}) : assert(appBloc != null) {
    appBloc.userStream.pipe(_userController);
  }

  @override
  void close() {
    super.close();
    _userController.close();
    _firebaseUserSubscription.cancel();
  }

  @override
  MoreState get initialState => InitialMoreState();

  @override
  Stream<MoreState> mapEventToState(MoreEvent event,) async* {
    if (event is SignOutEvent) {
      Auth.signOut();
      goToWelcomeScreen(event.context);
    } else if (event is ChangeNicknameEvent) {
      goToNicknameScreen(event.context);
    } else if (event is ChangeUserNeedsEvent) {
      goToUserNeedsScreen(event.context);
    }
  }
}
