import 'dart:async';
import 'package:flutter/services.dart';

export 'paystack_transaction.dart';
export 'payment_card.dart';

class PaystackSDK {
  static const _methodChannel = const MethodChannel('paystack_sdk');

  static Future initialize(String paystackKey) async {
    return _methodChannel.invokeMethod('initializePaystack', paystackKey);
  }
}
