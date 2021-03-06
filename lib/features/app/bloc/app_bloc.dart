import 'dart:async';
import 'dart:developer';

import 'package:better_help/common/auth0/auth.dart';
import 'package:better_help/features/app/components/notification.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import './bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
    static const _TAG = "AppBloc";
    final _notificationController = BehaviorSubject<FCNotification>();

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
    Stream<AppState> mapEventToState(AppEvent event,) async* {
        if (event is AppStateChange) {
            log(event.state.toString(), name: _TAG, time: DateTime.now());
            switch (event.state) {
                case AppLifecycleState.inactive:
                    break;
                case AppLifecycleState.resumed:
                    Auth.beOnline();
                    break;
                case AppLifecycleState.paused:
                    Auth.beOffline();
                    break;
                case AppLifecycleState.suspending:
                    break;
            }
        } else if (event is SaveDeviceTokenEvent) {
            if (event.token != null) {
                final user = await Auth.currentUser();
                if (user != null) {
                    Auth.addDeviceToken(token: event.token);
                }
            }
        } else if (event is PushNotificationEvent) {
            _notificationController.add(
                FCNotification(title: event.title, content: event.content));
        }
    }
}
