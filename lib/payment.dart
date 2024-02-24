import 'dart:collection';
import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'keys.dart';


class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}


Future<void> lipaNaMpesa() async {
  dynamic transactionInitialisation;
//Wrap it with a try-catch
  try {
//Run it
    transactionInitialisation =
    await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: "174379",//use your store number if the transaction type is CustomerBuyGoodsOnline
        transactionType: TransactionType.CustomerPayBillOnline, //or CustomerBuyGoodsOnline for till numbers
        amount: 10,
        partyA: "254710522753",
        partyB: "174379",
        callBackURL: Uri(scheme: "https",
            host: "mpesa-requestbin.herokuapp.com",
            path: "/1hhy6391"),
        accountReference: 'Payment',
        phoneNumber: "254710522753",
        baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
        transactionDesc: 'Fare',
        passKey: 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');

    print("TRANSACTION RESULT: " + transactionInitialisation.toString());
    return transactionInitialisation;

  } catch (e) {
//you can implement your exception handling here.
//Network un-reachability is a sure exception.

    /*
  Other 'throws':
  1. Amount being less than 1.0
  2. Consumer Secret/Key not set
  3. Phone number is less than 9 characters
  4. Phone number not in international format(should start with 254 for KE)
   */

    print("CAUGHT EXCEPTION: " + e.toString());
  }
}


class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            lipaNaMpesa();
          },
      ),
    );
  }
}

