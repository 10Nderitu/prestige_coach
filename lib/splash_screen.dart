import 'package:flutter/material.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect ()async {
    await Future.delayed(Duration.zero);
    final session = supabase.auth.currentSession;

    if (!mounted) return;
    if (session != null) {
      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      Navigator.of(context).pushReplacementNamed('/signup');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
