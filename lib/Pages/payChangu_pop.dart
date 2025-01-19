import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class PayChanguInlinePopup extends StatefulWidget {
  final String publicKey;
  final double amount;
  final String currency;
  final String callbackUrl;
  final String returnUrl;
  final String email;
  final String name;
 

  const PayChanguInlinePopup({
    Key? key,
    required this.publicKey,
    required this.amount,
    required this.currency,
    required this.callbackUrl,
    required this.returnUrl,
    required this.email,
    required this.name,
   
  }) : super(key: key);

  @override
  _PayChanguInlinePopupState createState() => _PayChanguInlinePopupState();
}

class _PayChanguInlinePopupState extends State<PayChanguInlinePopup> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          onWebResourceError: (error) {
            print('Error loading page: ${error.description}');
          },
        ),
      );

    _loadPayChanguInlinePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay with PayChangu'),
        backgroundColor: Colors.green,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }

  void _loadPayChanguInlinePage() {
    final String paymentPage = '''
      <html>
        <head>
       
          <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
          <script src="https://in.paychangu.com/js/popup.js"></script>
          <style>
            body, html {
              margin: 0;
              height: 100%;
              display: flex;
              align-items: center;
              justify-content: center;
              background-color: #f9f9f9;
            }
            #wrapper {
              width: 80%;
              max-width: 600px;
              padding: 20px;
              background-color: #ffffff;
              border-radius: 8px;
              box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
              text-align: center;
            }
            button {
              padding: 15px;
              background-color: #4CAF50;
              color: white;
              border: none;
              border-radius: 4px;
              cursor: pointer;
            }
            button:hover {
              background-color: #45a049;
            }
          </style>
        </head>
        <body>
          <div id="wrapper">
            <h2>Complete Your Payment</h2>
            <button type="button" id="start-payment-button" onClick="makePayment()">Pay Now</button>
          </div>
          <script>
            function makePayment(){
              PaychanguCheckout({
                "public_key": "pub-live-cXmknoqlCfja0fhjW2XpE1qhfKWcBZs4",
                "tx_ref": '' + Math.floor((Math.random() * 1000000000) + 1),
                "amount": ${widget.amount},
                "currency": "${widget.currency}",
                "callback_url": "${widget.callbackUrl}",
                "return_url": "${widget.returnUrl}",
                "customer": {
                  "email": "${widget.email}",
                  "first_name": "${widget.name}",
                },
                "customization": {
                  "title": "Payment Title",
                  "description": "Payment for Order"
                },
                "meta": {
                  "uuid": "your_uuid_value",
                  "response": "Response Data"
                }
              });
            }
          </script>
        </body>
      </html>
    ''';

    // Load the payment HTML page into the WebView
    _controller.loadRequest(
      Uri.dataFromString(paymentPage,
          mimeType: 'text/html', encoding: Encoding.getByName('utf-8')),
    );
  }
}