import 'package:after_layout/after_layout.dart';
import 'package:better_help/common/data/models/message.dart';
import 'package:better_help/common/data/models/message_group.dart';
import 'package:better_help/common/ui/screen_loading.dart';
import 'package:better_help/common/utils/time_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc/bloc.dart';

class MessageGroupCard extends StatefulWidget {
  final String messageGroupId;

  const MessageGroupCard({
    Key key,
    @required this.messageGroupId,
  })
      : assert(messageGroupId != null),
        super(key: key);

  @override
  _MessageGroupCardState createState() => _MessageGroupCardState();
}

class _MessageGroupCardState extends State<MessageGroupCard>
    with AfterLayoutMixin {
  bool isInitialize = false;
  GroupCardBloc groupCardBloc;

  @override
  void dispose() {
    super.dispose();
    groupCardBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return isInitialize ? StreamBuilder<MessageGroup>(
        stream: groupCardBloc.messageGroupStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final messageGroup = snapshot.data;

          return StreamBuilder<Message>(
              stream: groupCardBloc.latestGroupStream,
              builder: (context, snapshot) {
                Text nullText;
                if (!snapshot.hasData) {
                  nullText = Text('');
                }
                final latestMessage = snapshot.data;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      messageGroup.imageUrl,
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(messageGroup.displayName),
                      nullText == null
                          ? Text(getHourAndMinute(
                          latestMessage.updated ?? latestMessage.created))
                          : nullText,
                    ],
                  ),
                  subtitle: nullText == null
                      ? Text(latestMessage.content)
                      : nullText,
                  onTap: () => groupCardBloc.add(MakeChattingEvent(context)),
                );
              });
        }) : Center(child: ScreenLoading(),);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    groupCardBloc = Provider.of<GroupCardBloc>(context);
    groupCardBloc.initStream(widget.messageGroupId);
    setState(() {
      isInitialize = true;
    });
  }
}
