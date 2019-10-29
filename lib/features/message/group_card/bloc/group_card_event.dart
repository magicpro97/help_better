import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GroupCardEvent extends Equatable {}

class MakeChattingEvent extends GroupCardEvent {
  final BuildContext context;

  MakeChattingEvent(this.context);

  @override
  List<Object> get props => [context];
}
