import 'dart:async';
import 'package:flutter/services.dart';
import 'payment_card.dart';

class PaystackTransaction {
  static const _methodChannel = const MethodChannel('paystack_sdk');

  String email;
  int amount;

  PaystackTransaction(String email, int amount) {
    this.email = email;
    this.amount = amount;
  }

  Future<String> chargeCard(PaymentCard card) async {
    // create map to send to platform method handler
    Map<String, dynamic> args = {
      "email": this.email,
      "amount": this.amount,
      "cardNumber": card.cardNumber,
      "cvc": card.cvc,
      "expiryMonth": card.expiryMonth,
      "expiryYear": card.expiryYear
    };

    return _methodChannel.invokeMethod("chargeCard", args)
      .then<String>((dynamic result) => result);
  }
}