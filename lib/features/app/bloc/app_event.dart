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

class SaveDeviceTokenEvent extends AppEvent {
    final String token;
    
    SaveDeviceTokenEvent({@required this.token});
    
    @override
    List<Object> get props => null;
}