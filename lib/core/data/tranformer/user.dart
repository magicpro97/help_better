import 'dart:async';

import 'package:better_help/core/data/models/user_model.dart';
import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/features/need_help/presentation/bloc/bloc.dart';
import 'package:better_help/features/need_help/presentation/widgets/need_card_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

final toUserList =
StreamTransformer<QuerySnapshot, List<UserModel>>.fromHandlers(
  handleData: (data, sink) =>
      sink.add(
        data.documents.map((doc) => UserModel.fromJson(doc.data)).toList(),
      ),
  handleError: (data, trace, sink) => sink.addError(data, trace),
);

final toUser = StreamTransformer<DocumentSnapshot, UserModel>.fromHandlers(
  handleData: (data, sink) => sink.add(UserModel.fromJson(data.data)),
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
                    needHelpBloc.add(PressOnUserItem(
                        user: user, context: context, otherUser: otherUser)),
              ))
          .toList()),
      handleError: (data, trace, sink) => sink.addError(data, trace),
    );
