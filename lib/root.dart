import 'package:flutter/material.dart';
import 'package:prestige_coach/profile.dart';
import 'package:prestige_coach/trips.dart';
import 'booking_field.dart';


class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  final titles = ['START YOUR BOOKING', 'HISTORY', 'PROFILE'];
  int currentIndex = 0;

  final content = <Widget>[
    const BookingField(),
    const Trips(),
    const Profile(),
  ];

  final navItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.list),label: 'Trips'),
    const BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: Text(
          titles[currentIndex],
          style: const TextStyle(fontWeight: FontWeight.bold,),
        ),
        centerTitle: true,
      ),
      body: content[currentIndex],
      bottomNavigationBar: BottomNavigationBar(items: navItems,
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
          currentIndex = index;
        });
      },),
    );
  }
}
