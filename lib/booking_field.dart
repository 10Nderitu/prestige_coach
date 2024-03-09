import 'package:flutter/material.dart';
import 'package:prestige_coach/choose_bus.dart';
import 'package:prestige_coach/main.dart';
import 'package:prestige_coach/profile.dart';
import 'package:prestige_coach/repository/repository.dart';

class BookingField extends StatefulWidget {
  const BookingField({super.key});

  @override
  State<BookingField> createState() => _BookingFieldState();
}

class _BookingFieldState extends State<BookingField> {

  List<DropdownMenuItem<String>> get location {
    return [

      const DropdownMenuItem(
        value: 'Nairobi',
        child: Text('Nairobi'),
      ),
      const DropdownMenuItem(
        value: 'Mombasa',
        child: Text('Mombasa'),
      ),
    ];
  }

  List<DropdownMenuItem<String>> get time {
    return [
      const DropdownMenuItem(
        value: '1',
        child: Text('8 AM'),
      ),
      const DropdownMenuItem(
        value: '2',
        child: Text('10 PM'),
      ),
    ];
  }

  DateTime selectedDate = DateTime.now();
  final TextEditingController _dateController = TextEditingController();

  int myIndex = 0;
  String startLocation = '';
  String endLocation = '';
  int myCurrentIndex = 0;
  String selectedTime = '';

  List pages = [
    const BookingField(),
    const ChooseBus(),
    const Profile(),
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
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButtonFormField(
              items: location,
              onChanged: (value) {

              print(value);
                  startLocation = value!;
                  print(value);
                  print(startLocation);

                //print(location);
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
              height: 10,
            ),
            const Text(
              'TO',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButtonFormField(
              items: location,
              onChanged: (value) {

                print(value);
                endLocation = value!;
                print(value);
                print(endLocation);
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
                fontWeight: FontWeight.bold,
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
            const SizedBox(height: 10),
            const Text(
              'TIME',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButtonFormField(
              items: time,
              onChanged: (value) {
                print(value);
                selectedTime = value!;
                print(time);
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.timelapse),
                hintText: 'Time of travel',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.blue.shade200,
              ),
            ),

            //pages[myCurrentIndex],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await Repository().getAvailableBuses(startLocation, endLocation, _dateController.text, selectedTime);
          if(res != null)
            {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => BusPage));
            }
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
