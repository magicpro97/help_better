import 'package:equatable/equatable.dart';

abstract class NeedHelpState extends Equatable {
  const NeedHelpState();
}

class InitialNeedHelpState extends NeedHelpState {
  @override
  List<Object> get props => [];
}
