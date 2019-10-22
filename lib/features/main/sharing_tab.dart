import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SharingTab extends StatefulWidget {
  final String url = 'https://tinhte.vn/';

  @override
  _SharingTabState createState() => _SharingTabState();
}

class _SharingTabState extends State<SharingTab> {
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), (){
      if (!isLoaded) {
        setState(() {
          isLoaded = !isLoaded;
        });
      }
    });

    return Container(
      child: SafeArea(
        child: isLoaded ? WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {},
          onPageFinished: (value) {
            log("Loaded: $value");
          },
        ) : CupertinoActivityIndicator(),
      ),
    );
  }
}
