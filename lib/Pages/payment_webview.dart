import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  final String checkoutUrl;

  PaymentWebView({required this.checkoutUrl});

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition if needed (for Android)
    if (WebViewPlatform.instance is AndroidWebViewPlatform) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Payment'),
      ),
      body: WebView(
        initialUrl: widget.checkoutUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        navigationDelegate: (NavigationRequest request) {
          // Handle navigation events (e.g., redirects after payment)
          print('Navigating to: ${request.url}');
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}