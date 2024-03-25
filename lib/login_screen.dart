import 'package:flutter/material.dart';
import 'package:prestige_coach/root.dart';
import 'package:prestige_coach/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
              const SizedBox(
              height: 10,
            ),
              const Image(
                width: 300, height: 300, image: AssetImage("images/van.png")),
              const Text(
              'Welcome to TransMobi',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.blue.shade200,
                ),
              ),
            ),
              const SizedBox(
              height: 10,
            ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.blue.shade200,
                ),
              ),
            ),
               const SizedBox(
              height: 10,
            ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final res = await supabase.auth.signInWithPassword(
                      password: passwordController.text,
                      email: emailController.text.trim());
                  if (res != null) {
                    print(res.user!.email);
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('first_name', res.user!.userMetadata!['first_name']);
                    prefs.setString('last_name', res.user!.userMetadata!['last_name']);
                    prefs.setInt('phone', res.user!.userMetadata!['phone']);
                    prefs.setString('email', res.user!.email!);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Root()));
                  }
                } on Exception catch (e) {
                  print(e);
                  // Show AlertDialog for wrong email or password
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Login failed'),
                        content: const Text(style: TextStyle(fontSize: 15),'Wrong email or password. Please try again.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the AlertDialog
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
                child: const Text("Login"),
            ),

              InkWell(
                child: const Text.rich(
                  TextSpan(
                    text: "Don't have an account?",
                      children: [
                    TextSpan(
                        text: " Sign Up",
                        style: TextStyle(
                          color: Colors.blue,
                        )),
                  ],
                ),
              ),
                onTap: () {
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      )),
    ));
  }
}
