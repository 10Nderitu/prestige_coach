import 'package:flutter/material.dart';
import 'package:prestige_coach/booking_field.dart';
import 'package:prestige_coach/choose_bus.dart';
import 'package:prestige_coach/login_screen.dart';
import 'package:prestige_coach/signup_screen.dart';
import 'package:prestige_coach/trips.dart';
import 'package:prestige_coach/profile.dart';


class Trips extends StatefulWidget {
  const Trips({super.key});

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Text('YOUR PROFILE'),
        centerTitle: true,
      ),
    );
  }
}
