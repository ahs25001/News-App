import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/data/models/newsResponse.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleScreen extends StatefulWidget {
  static const String routeName = 'articleScreen';
  String url;

  ArticleScreen(this.url, {super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late WebViewController controller;
  bool loading = false;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              loading = true;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              loading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              loading = false;
            });
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("News App"),
      ),
      body: (loading)?Center(child: CircularProgressIndicator(color: Colors.green,),):WebViewWidget(controller: controller),
    );
  }
}
