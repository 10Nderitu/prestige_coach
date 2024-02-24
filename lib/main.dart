import 'dart:collection';

import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/material.dart';
import 'package:prestige_coach/payment.dart';
import 'package:prestige_coach/seat_provider.dart';
import 'package:prestige_coach/seat_widget.dart';
import 'package:prestige_coach/selection_button_page.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:prestige_coach/booking_field.dart';
import 'package:prestige_coach/choose_bus.dart';
import 'package:prestige_coach/common_scaffold.dart';
import 'package:prestige_coach/login_screen.dart';
import 'package:prestige_coach/seat_selection.dart';
import 'package:prestige_coach/signup_screen.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

import 'keys.dart';

Future <void> main() async {
  MpesaFlutterPlugin.setConsumerKey(mConsumerKey);
  MpesaFlutterPlugin.setConsumerSecret(mConsumerSecret);



  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qjucgecqxghxuurhykiq.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFqdWNnZWNxeGdoeHV1cmh5a2lxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDc5MDQ4MDcsImV4cCI6MjAyMzQ4MDgwN30.wvBXy_-cfnSKnLuclhdFcIEaOGrGULvImJAQlSb2Tik',
  );
  runApp(const MyApp());
}
final supabase = Supabase.instance.client;

  Future<dynamic> startTransaction({required double amount, required String phone}) async {
    dynamic transactionInitialisation;
//Wrap it with a try-catch
    try {
//Run it
      transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: '174379',//use your store number if the transaction type is CustomerBuyGoodsOnline
          transactionType: TransactionType.CustomerPayBillOnline, //or CustomerBuyGoodsOnline for till numbers
          amount: 10,
          partyA: "254710522753",
          partyB: '174379',
          callBackURL: Uri(),
          accountReference: 'Payment',
          phoneNumber: phone,
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectionButtonProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Prestige Coach',
        home: Payment(),
        // SeatSelection(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
      ),
    );
  }
}
