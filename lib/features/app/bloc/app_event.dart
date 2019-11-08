import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class AppStateChange extends AppEvent {
  final AppLifecycleState state;

  AppStateChange({@required this.state});

  @override
  List<Object> get props => [state];
}