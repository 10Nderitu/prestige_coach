import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';


class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

Future<void> lipaNaMpesa() async {
  dynamic transactionInitialisation;

  try {

    transactionInitialisation =
    await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: "174379",  //store number
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: 1,
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

    print("CAUGHT EXCEPTION: " + e.toString());
  }
}


class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Text('PROCEED TO PAY'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Image(
              height: 300, width: 400, image: AssetImage("images/van.png")),
          MaterialButton(
              onPressed: () {
                lipaNaMpesa();
              },
            color: Colors.green,
            height: 50,
            child: const Text('LIPA NA MPESA'),
          )
        ],
      ),
    );
  }
}

