import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Trips extends StatefulWidget {
  const Trips({Key? key}) : super(key: key);

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  late String fromLocation;
  late String toLocation;
  late String date;
  late String time;

  @override
  void initState() {
    super.initState();

    // Retrieve data from SharedPreferences
    _getDataFromSharedPreferences();
  }

  // Function to retrieve data from SharedPreferences
  Future<void> _getDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fromLocation = prefs.getString('startLocation') ?? 'Default From Location';
      toLocation = prefs.getString('endLocation') ?? 'Default To Location';
      date = prefs.getString('date') ?? 'Default Date';
      time = prefs.getString('selectedTime') ?? 'Default Time';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trips'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: const Text('From Location:'),
                subtitle: Text(fromLocation),
              ),
              ListTile(
                title: const Text('To Location:'),
                subtitle: Text(toLocation),
              ),
              ListTile(
                title: const Text('Date:'),
                subtitle: Text(date),
              ),
              ListTile(
                title: const Text('Time:'),
                subtitle: Text(time),
              ),
              // You can add more ListTile widgets for other details
            ],
          ),
        ),
      ),
    );
  }
}
