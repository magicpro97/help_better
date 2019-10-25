import 'dart:async';

import 'package:better_help/common/data/models/message_group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final toMessageGroupList =
    StreamTransformer<QuerySnapshot, List<MessageGroup>>.fromHandlers(
  handleData: (data, sink) => sink.add(
      data.documents.map((doc) => MessageGroup.fromJson(doc.data)).toList()),
);
