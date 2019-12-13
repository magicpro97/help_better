import 'package:better_help/common/dimens.dart';
import 'package:better_help/common/ui/screen_title.dart';
import 'package:better_help/core/data/tranformer/message_group.dart';
import 'package:better_help/core/domain/entities/user.dart';
import 'package:better_help/features/message/presentation/bloc/bloc.dart';
import 'package:better_help/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/message_group_card.dart';

class MessageTab extends StatelessWidget {
  final User currentUser;
  final List<User> friends;
  
  const MessageTab(
      {Key key, @required this.currentUser, @required this.friends})
      : assert(currentUser != null),
        assert(friends != null),
        super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil.getInstance();

    return SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: screenUtil.setHeight(Dimens.top_space),
                ),
                ScreenTitle(
                  title: S
                      .of(context)
                      .main_message,
                ),
                Expanded(
                    child: StreamBuilder<List<MessageGroupCard>>(
                        stream: BlocProvider.of<MessageBloc>(context)
                            .listMessageGroupList(userId: currentUser.id)
                            .transform(toMessageGroupCardList(
                            currentUser: currentUser, friends: friends)),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          }
                          
                          if (snapshot.hasError) {
                            return Center(
                              child:
                              Text('Something happens. ${snapshot.error}'),
                            );
                          }
                          final messageGroupCard = snapshot.data;
                          
                          return ListView.builder(
                            itemBuilder: (context, index) =>
                            messageGroupCard[index],
                            itemCount: messageGroupCard.length,
                          );
                        }))
              ],
            ),
          ),
        ),
    );
  }
}
