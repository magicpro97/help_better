import 'dart:async';

import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/features/need_help/components/need_card_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final toListUser = StreamTransformer<QuerySnapshot, List<User>>.fromHandlers(
  handleData: (data, sink) =>
      sink.add(
        data.documents.map((doc) => User.fromJson(doc.data)).toList(),
      ),
  handleError: (data, trace, sink) => sink.addError(data, trace),
);

final toUser = StreamTransformer<DocumentSnapshot, User>.fromHandlers(
  handleData: (data, sink) => sink.add(User.fromJson(data.data)),
  handleError: (data, trace, sink) => sink.addError(data, trace),
);

final toNeedCardItemList =
StreamTransformer<List<User>, List<NeedCardItem>>.fromHandlers(
  handleData: (data, sink) =>
      sink.add(data
          .map((user) =>
          NeedCardItem(
            user: user,
          ))
          .toList()),
  handleError: (data, trace, sink) => sink.addError(data, trace),
);
