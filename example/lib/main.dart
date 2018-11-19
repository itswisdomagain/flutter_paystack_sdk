import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:paystack_sdk/paystack_sdk.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _message = '';
  bool _paymentReady = false;

  @override
  void initState() {
    super.initState();
    initPaystack();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPaystack() async {
    displayMessage("Initializing Paystack");
    
    String paystackKey = "pk_test_71cb8fa98c03c73d3ff040d7ba712af4921b3bf9";
    try {
      await PaystackSDK.initialize(paystackKey);
      _paymentReady = true;
      displayMessage("Paystack Initialized. Ready to receive payment");
    } on PlatformException {
      displayError("Error intializing Paystack key to $paystackKey");
    }
  }

  initPayment() {
    if (!_paymentReady) {
      return;
    }

    displayMessage("Starting transaction...");
    _paymentReady = false;

    /*
    Test OTP Card from Paystack
    50606 66666 66666 6666
    CVV: 123
    PIN: 1234
    TOKEN: 123456
    EXPIRY: any date in the future
    */
    var card = PaymentCard("5060666666666666666", "123", 12, 2020);
    var transaction = PaystackTransaction("abc@gmail.com", 100000); // amount in kobo
    
    transaction.chargeCard(card)
      .then((transactionReference) {
        displayMessage("Transaction complete\nReference: $transactionReference");
        _paymentReady = true;
      })
      .catchError((e) {
        displayError(e.message);
        _paymentReady = true;
      });
  }

  displayMessage(String message) {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _message = message;
    });
  }

  displayError(String error) {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _message = 'Error:\n$error';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Paystack Flutter SDK Sample'),
        ),
        body: Center(
          child: Text(_message),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: initPayment,
          tooltip: 'Init Payment',
          child: Icon(Icons.payment),
        ),
      ),
    );
  }
}
