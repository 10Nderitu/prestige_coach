import 'package:flutter/material.dart';
import 'package:prestige_coach/booking_field.dart';
import 'package:prestige_coach/choose_bus.dart';
import 'package:prestige_coach/profile.dart';
import 'package:prestige_coach/seat_selection.dart';
import 'package:prestige_coach/trips.dart';

class CommonScaffold extends StatefulWidget {
  const CommonScaffold({super.key});

  @override
  State<CommonScaffold> createState() => _CommonScaffoldState();
}

class _CommonScaffoldState extends State<CommonScaffold> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    BookingField(),
    ChooseBus(),
    Profile(),
  ];

  void _onItemTap(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue.shade200,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        // selectedItemColor: Colors.black,
        elevation: 40,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
            // backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Trips',
            // backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            // backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}