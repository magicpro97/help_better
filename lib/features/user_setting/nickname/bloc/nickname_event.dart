import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NicknameEvent extends Equatable {
  const NicknameEvent();
}

class SaveNewNickname extends NicknameEvent {
  final BuildContext context;
  final String nickname;

  SaveNewNickname({@required this.context, @required this.nickname});

  @override
  List<Object> get props => [nickname];
}
