import 'package:bkash/bkash.dart';
import 'package:flutter/material.dart';

void onTapPayment(String method, BuildContext context, double amount) {
  switch (method) {
    case 'bkash':
      bkashPaymentMethod(context,amount);
      break;
    case 'nagad':
      nagadPaymentMethod();
      break;

    default:
      print('Something went wrong');
  }
}

final bkash = Bkash(logResponse: true);
void bkashPaymentMethod(BuildContext context, double amount) async {
  try {
  final response = await bkash.pay(
      context: context,
      amount: amount,
      merchantInvoiceNumber: '555555555',
    );

  print(response.paymentId);
  print(response.trxId);
  } on BkashFailure catch (e) {
    print(e.message.toString());
  }
}

void nagadPaymentMethod() {}
