import 'package:flutter/foundation.dart'; // For defaultTargetPlatform
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Core WebView package
import 'package:webview_flutter_android/webview_flutter_android.dart'; // Android-specific configuration
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart'; // iOS-specific configuration
import 'package:webview_windows/webview_windows.dart'; // Windows-specific configuration

class PaymentWebView extends StatefulWidget {
  final String checkoutUrl;

  const PaymentWebView({Key? key, required this.checkoutUrl}) : super(key: key);

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  WebViewController? _webViewController; // For Android & iOS
  WebviewController? _windowsWebViewController; // For Windows

  @override
  void initState() {
    super.initState();

    if (defaultTargetPlatform == TargetPlatform.android) {
      // Android-specific configuration
      final params = AndroidWebViewControllerCreationParams();
      _webViewController = WebViewController.fromPlatformCreationParams(params);
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      // iOS-specific configuration
      final params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
      _webViewController = WebViewController.fromPlatformCreationParams(params);
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      // Windows-specific configuration
      _windowsWebViewController = WebviewController()
        ..initialize().then((_) {
          _windowsWebViewController?.loadUrl(widget.checkoutUrl);
          setState(() {}); // Refresh UI after initialization
        });
    } else {
      throw UnsupportedError('Unsupported platform: $defaultTargetPlatform');
    }

    // Configure the WebViewController if not on Windows
    _webViewController?.setJavaScriptMode(JavaScriptMode.unrestricted);
    _webViewController?.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          print('Loading: $progress%');
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        onNavigationRequest: (NavigationRequest request) {
          print('Navigating to: ${request.url}');
          if (request.url.contains('payment-success')) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Payment successful!')),
            );
            return NavigationDecision.prevent;
          } else if (request.url.contains('payment-failed')) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Payment failed. Please try again.')),
            );
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );

    _webViewController?.loadRequest(Uri.parse(widget.checkoutUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Payment')),
      body: defaultTargetPlatform == TargetPlatform.windows
          ? _windowsWebViewController != null
              ? Webview(_windowsWebViewController!) // Windows WebView
              : const Center(child: CircularProgressIndicator())
          : WebViewWidget(controller: _webViewController!), // Mobile WebView
    );
  }
}
