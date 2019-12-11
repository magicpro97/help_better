import 'dart:async';

import 'package:better_help/features/message/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final toMessage =
    StreamTransformer<DocumentSnapshot, MessageModel>.fromHandlers(
  handleData: (data, sink) => sink.add(MessageModel.fromJson(data.data)),
  handleError: (data, trace, sink) => sink.addError(data, trace),
);

final toMessageList =
    StreamTransformer<QuerySnapshot, List<MessageModel>>.fromHandlers(
  handleData: (data, sink) => sink.add(
      data.documents.map((doc) => MessageModel.fromJson(doc.data)).toList()),
  handleError: (data, trace, sink) => sink.addError(data, trace),
);

final toLatestMessage =
    StreamTransformer<List<MessageModel>, MessageModel>.fromHandlers(
  handleData: (data, sink) => sink.add(data.last),
  handleError: (data, trace, sink) => sink.addError(data, trace),
);
