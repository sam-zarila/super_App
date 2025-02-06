import 'package:flutter/foundation.dart'; // For defaultTargetPlatform
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Core WebView package
import 'package:webview_flutter_android/webview_flutter_android.dart'; // Android-specific configurations
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart'; // iOS-specific configurations

class PaymentWebView extends StatefulWidget {
  final String checkoutUrl;

  const PaymentWebView({Key? key, required this.checkoutUrl}) : super(key: key);

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();

    // Initialize platform-specific creation parameters.
    late final PlatformWebViewControllerCreationParams params;

    if (defaultTargetPlatform == TargetPlatform.android) {
      // Android-specific configuration.
      params = AndroidWebViewControllerCreationParams();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      // iOS-specific configuration.
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      // For Windows, use default creation parameters.
      params = const PlatformWebViewControllerCreationParams();
    } else {
      throw UnsupportedError('Unsupported platform: ${defaultTargetPlatform}');
    }

    // Create the WebViewController using the platform-specific parameters.
    _webViewController = WebViewController.fromPlatformCreationParams(params);

    // Configure the WebViewController.
    _webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
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
              // Navigate back with a success message.
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment successful!')),
              );
              return NavigationDecision.prevent;
            } else if (request.url.contains('payment-failed')) {
              // Navigate back with an error message.
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment failed. Please try again.')),
              );
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));

    // Android-specific settings (if needed)
    if (_webViewController.platform is AndroidWebViewController) {
      final androidController = _webViewController.platform as AndroidWebViewController;
      androidController.setBackgroundColor(Colors.transparent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Payment'),
      ),
      body: WebViewWidget(
        controller: _webViewController,
      ),
    );
  }
}
