import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Import the webview_flutter package
import 'package:webview_flutter_android/webview_flutter_android.dart'; // For Android-specific configurations
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart'; // For iOS-specific configurations

class PaymentWebView extends StatefulWidget {
  final String checkoutUrl;

  PaymentWebView({required this.checkoutUrl});

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();

    // Initialize the WebViewController
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      // iOS/macOS-specific configuration
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else if(WebViewPlatform.instance is AndroidWebViewPlatform){
      // Android-specific configuration
      params = const PlatformWebViewControllerCreationParams();
    }
     else{

     }

    _webViewController = WebViewController.fromPlatformCreationParams(params);

    // Configure the WebViewController
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
            // Handle navigation events (e.g., redirects after payment)
            print('Navigating to: ${request.url}');
            if (request.url.contains('payment-success')) {
              // Navigate back to the app with a success message
              Navigator.of(context).pop(); // Close the WebView
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Payment successful!')),
              );
              return NavigationDecision.prevent; // Stop further navigation
            } else if (request.url.contains('payment-failed')) {
              // Navigate back to the app with an error message
              Navigator.of(context).pop(); // Close the WebView
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Payment failed. Please try again.')),
              );
              return NavigationDecision.prevent; // Stop further navigation
            }
            return NavigationDecision.navigate; // Allow navigation
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));

    // Configure Android-specific settings (if needed)
    if (_webViewController.platform is AndroidWebViewController) {
      final androidController = _webViewController.platform
          as AndroidWebViewController;
      androidController.setBackgroundColor(Colors.transparent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Payment'),
      ),
      body: WebViewWidget(
        controller: _webViewController,
      ),
    );
  }
}