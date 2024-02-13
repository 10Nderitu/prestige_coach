import 'package:flutter/material.dart';
import 'package:prestige_coach/login_screen.dart';
import 'package:prestige_coach/signup_screen.dart';
import 'package:prestige_coach/booking_field.dart';

class ChooseBus extends StatefulWidget {
  const ChooseBus({super.key});

  @override
  State<ChooseBus> createState() => _ChooseBusState();
}

class _ChooseBusState extends State<ChooseBus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Text('CHOOSE A VEHICLE'),
        centerTitle: true,
      ),

    );
  }
}
