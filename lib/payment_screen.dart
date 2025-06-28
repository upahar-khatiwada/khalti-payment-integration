import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const String END_POINT = 'https://dev.khalti.com/api/v2/epayment/initiate/';

final String secretKey = dotenv.env['SECRET_KEY']!;

Map<String, dynamic> payload = {
  "return_url": "https://example.com/payment/",
  "website_url": "https://example.com/",
  "amount": 1300,
  "purchase_order_id": "test12",
  "purchase_order_name": "test",
  "customer_info": {
    "name": "Khalti Bahadur",
    "email": "example@gmail.com",
    "phone": "9800000123",
  },
};

final payload_encoded = jsonEncode(payload);

Map<String, String> headers = {
  'Authorization': 'key $secretKey',
  'Content-Type': 'application/json',
};

class KhaltiPay extends StatelessWidget {
  const KhaltiPay({super.key});

  Future<void> paymentApi() async {
    http.Response response = await http.post(
      Uri.parse(END_POINT),
      headers: headers,
      body: payload_encoded,
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton.icon(
          onPressed: paymentApi,
          label: Text('Pay With Khalti', style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.payment, color: Colors.white),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent),
        ),
      ),
    );
  }
}
