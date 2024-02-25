import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebView extends StatefulWidget {
  static const String routeName = "ArticleWebView";

  const ArticleWebView({super.key});

  @override
  State<ArticleWebView> createState() => _ArticleWebViewState();
}

class _ArticleWebViewState extends State<ArticleWebView> {
  @override
  Widget build(BuildContext context) {
    var link = ModalRoute.of(context)?.settings.arguments as String;
    WebViewController controller = WebViewController()
      ..loadRequest(Uri.parse(link));
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
        ),
        backgroundColor: Colors.grey[600],
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        title: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: const Text(
              "web view",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
