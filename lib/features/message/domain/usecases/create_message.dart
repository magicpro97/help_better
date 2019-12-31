import 'dart:wasm';

import 'package:better_help/features/message/data/models/message_model.dart';
import 'package:better_help/features/message/domain/entities/message.dart';
import 'package:better_help/features/message/domain/repositories/message_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateMessage {
  final MessageRepository messageRepository;

  CreateMessage({this.messageRepository});

  // MessageModel call(String messageGroupId, Message message) {
  //   return messageRepository.createMessage(messageGroupId, message);
  // }
}