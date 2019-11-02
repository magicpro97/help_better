import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SharingTab extends StatefulWidget {
  @override
  _SharingTabState createState() => _SharingTabState();
}

class _SharingTabState extends State<SharingTab> {
  bool isLoaded = false;
  static const String _url = 'https://www.tamsuapp.com';

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      if (!isLoaded) {
        setState(() {
          isLoaded = !isLoaded;
        });
      }
    });

    return Container(
      child: SafeArea(
        child: isLoaded
            ? WebView(
          initialUrl: _url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {},
          onPageFinished: (value) {
            log("Loaded: $value");
          },
        )
            : CupertinoActivityIndicator(),
      ),
    );
  }
}
