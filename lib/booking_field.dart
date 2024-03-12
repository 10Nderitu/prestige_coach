import 'package:flutter/material.dart';
import 'package:prestige_coach/choose_bus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingField extends StatefulWidget {
  const BookingField({super.key});

  @override
  State<BookingField> createState() => _BookingFieldState();
}

class _BookingFieldState extends State<BookingField> {

  List<DropdownMenuItem<String>> get fromLocation {
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

  List<DropdownMenuItem<String>> get toLocation {
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
        value: '8 AM',
        child: Text('8 AM'),
      ),
      const DropdownMenuItem(
        value: '10 PM',
        child: Text('10 PM'),
      ),
    ];
  }

  DateTime selectedDate = DateTime.now();
  final TextEditingController _dateController = TextEditingController();

  String startLocation = '';
  String endLocation = '';
  String selectedTime = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Image(
                  height: 230, width: 400, image: AssetImage("images/van.png")),
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
                items: fromLocation,
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
                items: toLocation,
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
              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () async {
                  if (startLocation.isNotEmpty && endLocation.isNotEmpty && selectedTime.isNotEmpty && _dateController.text.isNotEmpty) {
                    if (startLocation == endLocation) {
                      // Show AlertDialog if from location is the same as to location
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(style: TextStyle(fontWeight: FontWeight.bold), 'Error'),
                            content: const Text( style: TextStyle(fontSize: 20) ,"'From Location' cannot be the same as the 'To Location'"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString('startLocation', startLocation);
                      prefs.setString('endLocation', endLocation);
                      prefs.setString('selectedTime', selectedTime);
                      prefs.setString('date', _dateController.text);

                      // Navigate to ChooseBus screen if all fields are filled and locations are different
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return ChooseBus(
                          start_location: startLocation,
                          end_location: endLocation,
                          time: selectedTime,
                        );
                      }));
                    }
                  } else {
                    // Show Snack bar if any field is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ensure all fields are filled'),
                      ),
                    );
                  }
                },
                child: const Text(style: TextStyle(fontWeight: FontWeight.bold), 'Next'),
              )

            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
