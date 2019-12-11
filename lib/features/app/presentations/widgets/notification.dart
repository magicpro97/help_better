import 'package:better_help/common/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PushNotification {
    static bool _isVisible = false;
    
    static Future<void> show(
        {@required BuildContext context, @required FCNotification notification,
            Duration duration = const Duration(seconds: 3),}) async {
        final overlayState = Overlay.of(context);
        final overlayEntry = OverlayEntry(
            builder: (context) =>
                NotificationCard(
                    title: notification.title, content: notification.content,));
        overlayState.insert(overlayEntry);
        
        if (_isVisible) {
            return;
        }
        
        _isVisible = true;
        
        await Future.delayed(duration);
        
        overlayEntry.remove();
        
        _isVisible = false;
    }
}

class FCNotification {
    final String title;
    final String content;

    FCNotification({@required this.title, @required this.content})
        : assert(title != null),
            assert(content != null);
}

class NotificationCard extends StatefulWidget {
    final String title;
    final String content;
    
    const NotificationCard({Key key, this.title, this.content,})
        : super(key: key);
    
    
    @override
    _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard>
    with SingleTickerProviderStateMixin {
    AnimationController _controller;
    Animation<Offset> _animation;
    
    @override
    void initState() {
        super.initState();
        _controller = AnimationController(
            duration: const Duration(milliseconds: 500), vsync: this);
        _animation =
            Tween<Offset>(begin: Offset(0.0, -4.0), end: Offset.zero).animate(
                CurvedAnimation(
                    parent: _controller, curve: Curves.bounceInOut));
        _controller.forward();
    }
    
    @override
    void dispose() {
        _controller.dispose();
        super.dispose();
    }
    
    @override
    Widget build(BuildContext context) {
        final screenUtil = ScreenUtil.instance;
        final titleTextStyle = Theme
            .of(context)
            .primaryTextTheme
            .title;
        final contentTextStyle = Theme
            .of(context)
            .primaryTextTheme
            .body1;
        
        return SafeArea(
            child: Material(
                color: Colors.transparent,
                child: Align(
                    alignment: Alignment.topCenter,
                    child: SlideTransition(
                        child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                                elevation: Dimens.elevation,
                                child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                            Text(widget.title,
                                                style: titleTextStyle.copyWith(
                                                    fontSize: screenUtil.setSp(
                                                        Dimens.h2_size)),),
                                            Text(widget.content,
                                                style: contentTextStyle
                                                    .copyWith(
                                                    fontSize: screenUtil.setSp(
                                                        Dimens.body1_size)),),
                                        ],
                                    ),
                                ),
                            ),
                        ), position: _animation,
                    ),
                ),
            ),);
    }
}