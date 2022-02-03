import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.06,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  PopupMenuButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    onSelected: (value) async {
                      if (value == 1) {
                        if (!await launch(widget.url)) throw 'Could not launch $widget.url';
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(child: Text("Open in browser"), value: 1),
                      PopupMenuItem(child: Text("Back ..."), value: 2),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height - (size.height * 0.06) - padding.top,
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: widget.url,
                onProgress: (int progress) {
                  // print('WebView is loading (progress : $progress%)');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
