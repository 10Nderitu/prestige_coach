import 'package:flutter/material.dart';
import 'package:prestige_coach/choose_bus.dart';
import 'package:prestige_coach/login_screen.dart';
import 'package:prestige_coach/profile.dart';
import 'package:prestige_coach/seat_selection.dart';
import 'package:prestige_coach/signup_screen.dart';
import 'package:prestige_coach/booking_field.dart';

class BookingField extends StatefulWidget {
  const BookingField({super.key});

  @override
  State<BookingField> createState() => _BookingFieldState();
}

class _BookingFieldState extends State<BookingField> {
  List<DropdownMenuItem<String>> get location {
    return [
      const DropdownMenuItem(
        value: '1',
        child: Text('Nairobi'),
      ),
      const DropdownMenuItem(
        value: '2',
        child: Text('Voi'),
      ),
      const DropdownMenuItem(
        value: '3',
        child: Text('Mombasa'),
      ),
    ];
  }

  DateTime selectedDate = DateTime.now();
  final TextEditingController _dateController = TextEditingController();

  int myIndex = 0;

  int myCurrentIndex = 0;

  List pages = [
    LoginScreen(),
    const Trips(),
    const ChooseBus(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade300,
          title: const Text('START YOUR BOOKING'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Image(
                  height: 300, width: 400, image: AssetImage("images/van.png")),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'FROM',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              DropdownButtonFormField(
                items: location,
                onChanged: (String? value) {
                  print(location);
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.location_city),
                  hintText: 'From Location',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.blue.shade200,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'TO',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              DropdownButtonFormField(
                items: location,
                onChanged: (String? value) {
                  print(location);
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.location_city),
                  hintText: 'To Location',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.blue.shade200,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'DATE',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  hintText: 'Select date of travel',
                  filled: true,
                  fillColor: Colors.blue.shade200,
                  prefixIcon: const Icon(Icons.calendar_month_rounded),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                ),
                readOnly: true,
                onTap: () {
                  _selectDate();
                },
              ),
              pages[myCurrentIndex],
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue.shade200,
          currentIndex: myIndex,
          onTap: (index) {
            setState(() {
              myCurrentIndex = index;
            });
          },

          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.menu_outlined), label: 'Trips'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),

        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => const ChooseBus()));
        },
          backgroundColor: Colors.blue.shade200,
          child: const Icon(Icons.navigate_next),

    ),

    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}

