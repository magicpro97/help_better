import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NicknameState extends Equatable {
  const NicknameState();
}

class InitialNicknameState extends NicknameState {
  @override
  List<Object> get props => null;
}
