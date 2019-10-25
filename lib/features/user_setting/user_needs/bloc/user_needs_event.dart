import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class UserNeedsEvent extends Equatable {
  final BuildContext context;

  const UserNeedsEvent(this.context);
}

class SelectOptionTeenageEvent extends UserNeedsEvent {
  final BuildContext context;

  SelectOptionTeenageEvent(this.context) : super(context);

  @override
  List<Object> get props => null;
}

class SelectOptionLoveEvent extends UserNeedsEvent {
  final BuildContext context;

  SelectOptionLoveEvent(this.context) : super(context);

  @override
  List<Object> get props => null;
}

class SelectOptionFamilyEvent extends UserNeedsEvent {
  final BuildContext context;

  SelectOptionFamilyEvent(this.context) : super(context);

  @override
  List<Object> get props => null;
}

class SelectOptionGoAheadEvent extends UserNeedsEvent {
  final BuildContext context;

  SelectOptionGoAheadEvent(this.context) : super(context);

  @override
  List<Object> get props => null;
}
