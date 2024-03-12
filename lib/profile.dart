import 'package:flutter/material.dart';
import 'package:prestige_coach/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  late String? email = '';
  late String? firstName = '';
  late String? lastName = '';


  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    firstName = prefs.getString('first_name');
    setState(() {
    });

    print(email);
  }
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(padding: const EdgeInsets.all(60),
        child: Column(
          children: [
            const CircleAvatar( radius:80, backgroundImage: AssetImage('images/profile.png')),
            const SizedBox(height: 20),
            Text(
              firstName!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height:10),
            Text(
              email!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  supabase.auth.signOut;
                  await prefs.clear();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: const Text('Sign Out'))
          ],
        ),
      )
    );
  }
}

