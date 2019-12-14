import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:better_help/core/domain/usecase/get_current_user.dart';
import 'package:better_help/core/domain/usecase/user_offline.dart';
import 'package:better_help/core/domain/usecase/user_online.dart';
import 'package:better_help/features/app/presentations/widgets/notification.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  static const _TAG = "AppBloc";
  final _notificationController = BehaviorSubject<FCNotification>();
  final GetCurrentUser getCurrentUser;
  final UserOnline userOnline;
  final UserOffline userOffline;
  final FirebaseMessaging firebaseMessaging;

  AppBloc(
      {@required this.getCurrentUser,
      @required this.userOnline,
      @required this.userOffline,
      @required this.firebaseMessaging});

  Stream<FCNotification> get notificationStream =>
      _notificationController.stream;

  @override
  Future<void> close() {
    _notificationController.close();
    return super.close();
  }

  @override
  AppState get initialState => InitialAppState();

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is AppStateChange) {
      log(event.state.toString(), name: _TAG, time: DateTime.now());
      final user = await getCurrentUser();
      switch (event.state) {
        case AppLifecycleState.inactive:
          break;
        case AppLifecycleState.resumed:
          userOnline(user);
          break;
        case AppLifecycleState.paused:
          userOffline(user);
          break;
        case AppLifecycleState.detached:
          break;
      }
    } else if (event is PushNotificationEvent) {
      _notificationController
          .add(FCNotification(title: event.title, content: event.content));
    } else if (event is ConfigFCM) {
      firebaseMessaging.configure(
        onMessage: (message) async {
          log(message.toString(), name: "onMessage");
        },
        onLaunch: (message) async {
          log(message.toString(), name: "onLauch");
        },
        onResume: (message) async {
          log(message.toString(), name: "onResume");
        },
        onBackgroundMessage: Platform.isIOS ? null : _messageBackground,
      );
    }
  }
}

Future<dynamic> _messageBackground(Map<String, dynamic> message) async {
  log(message.toString(), name: "onResume");
}
