import 'package:flutter/material.dart';
import 'package:prestige_coach/booking_field.dart';
import 'package:prestige_coach/choose_bus.dart';
import 'package:prestige_coach/login_screen.dart';
import 'package:prestige_coach/seat_selection.dart';
import 'package:prestige_coach/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prestige Coach',
      home: BookingField(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}
