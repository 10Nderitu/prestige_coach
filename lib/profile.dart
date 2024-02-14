import 'package:flutter/material.dart';
import 'package:prestige_coach/booking_field.dart';
import 'package:prestige_coach/choose_bus.dart';
import 'package:prestige_coach/login_screen.dart';
import 'package:prestige_coach/signup_screen.dart';
import 'package:prestige_coach/profile.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
