import 'package:equatable/equatable.dart';

abstract class MoreState extends Equatable {
  const MoreState();
}

class InitialMoreState extends MoreState {
  @override
  List<Object> get props => [];
}
