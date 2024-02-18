import 'package:flutter/material.dart';
import 'package:prestige_coach/booking_field.dart';
import 'package:prestige_coach/signup_screen.dart';

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
                const SizedBox(height: 10,),
        
                const Image(
                    width: 300,
                    height: 300,
                    image: AssetImage("images/van.png")),
        
                const Text(
                    'Welcome to Prestige Coach',
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
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.blue.shade200,
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.blue.shade200,
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
        
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const BookingField()));
                  },
                  child: const Text("Login"),
                ),
        
                   InkWell(
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account?",
                        children: [
                          TextSpan(text: " Sign Up", style: TextStyle(
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
          )
        ),
      )
    );
  }
}