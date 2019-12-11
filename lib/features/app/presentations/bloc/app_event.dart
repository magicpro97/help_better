import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class AppStateChange extends AppEvent {
  final AppLifecycleState state;
  
  AppStateChange({@required this.state}) : assert(state != null);
  
  @override
  List<Object> get props => [state];
}

class PushNotificationEvent extends AppEvent {
  final BuildContext context;
  final String title;
  final String content;
  
  PushNotificationEvent(
      {@required this.context, @required this.title, @required this.content})
      : assert(title != null),
        assert(content != null),
        assert(content != null);
  
  @override
  List<Object> get props => [title, content];
}

class ConfigFCM extends AppEvent {
  @override
  List<Object> get props => [];
}
