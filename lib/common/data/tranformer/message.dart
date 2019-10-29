import 'dart:async';
import 'dart:developer';

import 'package:better_help/common/data/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final toMessage = StreamTransformer<DocumentSnapshot, Message>.fromHandlers(
  handleData: (data, sink) => sink.add(Message.fromJson(data.data)),
  handleError: (data, trace, sink) => sink.addError(data, trace),
);

final toMessageList =
    StreamTransformer<QuerySnapshot, List<Message>>.fromHandlers(
  handleData: (data, sink) => sink
      .add(data.documents.map((doc) => Message.fromJson(doc.data)).toList()),
      handleError: (data, trace, sink) => sink.addError(data, trace),
);

final toLatestMessage = StreamTransformer<List<Message>, Message>.fromHandlers(
  handleData: (data, sink) => {log(data.last.toString()), sink.add(data.last)},
  handleError: (data, trace, sink) => sink.addError(data, trace),
);
