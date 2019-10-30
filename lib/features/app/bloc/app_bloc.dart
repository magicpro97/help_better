import 'dart:async';

import 'package:better_help/common/auth0/auth.dart';
import 'package:better_help/common/data/dao/user_dao.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import './bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final _userController = BehaviorSubject<User>();

  Function get changeUser => _userController.add;

  Stream<User> get userStream => _userController.stream;

  User get currentUser => _userController.value;

  AppBloc() {
    Auth.currentUser().then((user) => changeUser(user));

    Auth.firebaseUserStream.listen((data) {
      if (data != null) {
        UserDao.findById(data.uid).then((user) => changeUser(user));
      }
    });
  }

  @override
  void close() {
    super.close();
    _userController.drain((data) => _userController.close());
  }

  @override
  AppState get initialState => InitialAppState();

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {}
}
