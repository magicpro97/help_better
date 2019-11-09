import 'dart:async';

import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/features/need_help/bloc/need_help_bloc.dart';
import 'package:better_help/features/need_help/bloc/need_help_event.dart';
import 'package:better_help/features/need_help/components/need_card_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

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

StreamTransformer<List<User>, List<NeedCardItem>> toNeedCardItemList(
    {@required NeedHelpBloc needHelpBloc,
        @required BuildContext context,
        @required List<User> otherUser}) =>
    StreamTransformer.fromHandlers(
        handleData: (data, sink) =>
            sink.add(data
                .map((user) =>
                NeedCardItem(
                    user: user,
                    onTap: () =>
                        needHelpBloc.add(CreateMessageGroup(
                            user: user,
                            context: context,
                            otherUser: otherUser)),
                ))
          .toList()),
        handleError: (data, trace, sink) => sink.addError(data, trace),
    );
