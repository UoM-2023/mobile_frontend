import 'dart:math';
import 'package:apartflow_mobile_app/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';
import '../models/userDetails.dart';

class PayHereService {
  static void initiatePayment( User user, String title, double amount) {
    String order_id = generateOrderId(user.unitId);
    var paymentObject = {
      "sandbox": true,
      "merchant_id": "1226487 ", 
      "merchant_secret": "NDE1NDA2MDgxNjQxMjcwNDc5MTAzMDE1NDQ2NTM4MjU3MTczNTEwMQ==", 
      "notify_url": "${baseurl}/finance/notify",
      "order_id": order_id,
      "items": title,
      "amount": amount.toString(),
      "currency": "LKR",
      "first_name": user.first_name,
      "last_name": user.last_name,
      "email": user.email,
      "phone": user.mobileNo,
      "address": user.unitId,
      "city": "Colombo",
      "country": "Sri Lanka"
    };

    PayHere.startPayment(paymentObject, (paymentId) async {
      print("Payment Successful. Payment Id: $paymentId");
      print("Payhere: $amount");

      await _sendPaymentDataToBackend( user, title, amount, paymentId);
    }, (error) {
      print("Payment Failed. Error: $error");
    }, () {
      print("Payment Dismissed");
    });
  }

  static Future<void> _sendPaymentDataToBackend(User user, String title, double amount, String paymentId) async {
    print("Function: $amount");
      final response = await http.post(
        Uri.parse('${baseurl}/finance/payment'), // Replace with your backend server address
        body: jsonEncode({
          'user_id': user.userId,
          'unit_id': user.unitId,
          'charge_type': title,
          'method': 'Online', 
          'amount': amount,
          'payment_id': paymentId,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Payment data sent to backend successfully');
      } else {
        print('Failed to send payment data to backend: ${response.body}');
      }
  }

  static String generateOrderId(String userName) {
    int timeStamp = DateTime.now().microsecondsSinceEpoch;
    String uniquePart = Random().nextInt(1000000).toString();
    return '$userName-$timeStamp-$uniquePart';
  }
}