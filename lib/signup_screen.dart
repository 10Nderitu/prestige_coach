import 'package:flutter/material.dart';
import 'package:prestige_coach/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupScreen extends StatelessWidget {
  final supabase = Supabase.instance.client;

  SignupScreen({super.key});
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String combinedData = '${fNameController.text} ${lNameController.text}';
    await prefs.setString('savedData', combinedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Image(
                    height: 300,
                    width: 400,
                    image: AssetImage("images/van.png"),
                  ),
                ),
                const Text(
                  'Welcome to TransMobi',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: fNameController,
                    decoration: InputDecoration(
                      hintText: "First name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.blue.shade200,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: lNameController,
                    decoration: InputDecoration(
                      hintText: "Last name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.blue.shade200,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: numberController,
                    decoration: InputDecoration(
                      hintText: "Phone Number",
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
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    obscureText: true,
                    obscuringCharacter: '*',
                    controller: passwordController,
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
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await supabase.auth.signUp(
                        password: passwordController.text,
                        email: emailController.text.trim(),
                        data: {
                          'first_name': fNameController.text,
                          'last_name': lNameController.text,
                          'phone': int.parse(numberController.text),
                        },
                      );

                      // Successful sign-up
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sign up successful!'),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      // Navigate to the bookingfield page
                      Navigator.pushReplacementNamed(context,
                          '/bookingfield'); // Replace with your route name
                    } catch (error) {
                      // Failed sign-up
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sign up failed. Please try again.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: const Text("Sign Up"),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: const Text("Already have an account? Login"),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
