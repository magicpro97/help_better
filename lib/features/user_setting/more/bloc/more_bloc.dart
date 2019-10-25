import 'dart:async';

import 'package:better_help/common/auth0/auth.dart';
import 'package:better_help/common/data/dao/user_dao.dart';
import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/route/route.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import './bloc.dart';

class MoreBloc extends Bloc<MoreEvent, MoreState> {
  final _userController = BehaviorSubject<User>();

  User get user => _userController.value;

  Stream<User> get userStream => _userController.stream;

  Function get changeUser => _userController.add;

  StreamSubscription _firebaseUserSubscription;

  StreamSubscription _userSubscription;

  MoreBloc() {
    _firebaseUserSubscription = Auth.firebaseUserStream.listen((fbUser) {
      if (fbUser != null) {
        _userSubscription = UserDao.userStream(fbUser.uid).listen((newUser) {
          changeUser(newUser);
        });
      }
    });
  }

  @override
  void close() {
    super.close();
    _userController.close();
    _firebaseUserSubscription.cancel();
    _userSubscription.cancel();
  }

  @override
  MoreState get initialState => InitialMoreState();

  @override
  Stream<MoreState> mapEventToState(
    MoreEvent event,
  ) async* {
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
