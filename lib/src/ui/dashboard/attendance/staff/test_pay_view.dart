import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PaymentPage extends StatelessWidget {
  final String test = "Test Charge";
  final int amount = 100;
  final String paymentGatewayName = "Atomic";
  final String atomTokenId = "your_token_here";
  final String merchId = "your_merchant_id_here";
  final String custEmail = "customer@example.com";
  final String custMobile = "1234567890";
  final String returnUrl = "https://your-return-url.com";

  @override
  Widget build(BuildContext context) {
    String atomScript = "";
    if (paymentGatewayName == "Atomic") {
      atomScript = '''
        <script src="https://psa.atomtech.in/staticdata/ots/js/atomcheckout.js" type="text/javascript"></script>
        <script type="text/javascript">
          function openPay() {
            const options = {
              "atomTokenId": "$atomTokenId",
              "merchId": "$merchId",
              "custEmail": "$custEmail",
              "custMobile": "$custMobile",
              "returnUrl": "$returnUrl"
            };
            let atom = new AtomPaynetz(options, 'uat');
          }
        </script>
        <button onclick="openPay()">Pay with Atom</button>
      ''';
    }

    return MaterialApp(
      home: WebviewScaffold(
        url: Uri.dataFromString('''
        <html>
          <head>
            <meta name="viewport" content="width=device-width">
          </head>
          <body>
            <center>
              <form action="Your Server" method="POST">
                <script
                  src="https://checkout.stripe.com/checkout.js" class="stripe-button"
                  data-key="pk_test_key"
                  data-amount="$amount"
                  data-name="$test"
                  data-description="My Order"
                  data-image="https://stripe.com/img/documentation/checkout/marketplace.png"
                  data-locale="auto"
                  data-currency="eur">
                </script>
              </form>
              $atomScript
            </center>
          </body>
        </html>
        ''', mimeType: 'text/html').toString(),
      ),
    );
  }
}
