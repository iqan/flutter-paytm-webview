import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_paytm_webview/settings.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Payment extends StatefulWidget {
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  final orderId = 'TEST_12345678';
  final customerId = '12345678';
  final amount = '1.0';
  final email = 'abc@abc.com';

  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  String status;

  @override
  void dispose() {
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.close();

    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      print("destroy");
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      print("onStateChanged: ${state.type} ${state.url}");
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          print("URL changed: $url");
          if (url.contains('callback')) {
            var x = flutterWebviewPlugin.getCookies();
            flutterWebviewPlugin.evalJavascript('document').then((body) {
              print("status $body");
              flutterWebviewPlugin.close();
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final queryParams = '?order_id=$orderId&customer_id=$customerId&amount=$amount&email=$email';

    return new WebviewScaffold(
        url: Settings.apiUrl + queryParams,
        appBar: new AppBar(
          title: new Text("Pay using PayTM"),
        ));
  }
}
