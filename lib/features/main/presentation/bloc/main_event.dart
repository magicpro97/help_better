import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}

class CheckingUserSessionEvent extends MainEvent {
  final BuildContext context;

  CheckingUserSessionEvent({@required this.context});

  @override
  List<Object> get props => [context];
}
