import 'package:flutter/material.dart';
import 'package:prestige_coach/repository/repository.dart';
import 'package:prestige_coach/seat_grid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChooseBus extends StatefulWidget {
  const ChooseBus(
      {super.key,
      required this.start_location,
      required this.end_location,
      required this.time,
      required this.date});

  final String start_location;
  final String end_location;
  final String time;
  final String date;

  @override
  State<ChooseBus> createState() => _ChooseBusState();
}

class _ChooseBusState extends State<ChooseBus> {

  int bus_id = 0;
  int route_id = 0;

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: const Text(style: TextStyle(fontWeight: FontWeight.bold), 'AVAILABLE VEHICLES'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Repository().getAvailableBuses(
            widget.start_location, widget.end_location, widget.time),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Parse the snapshot data and display it
            final data = snapshot.data!;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3, // Add elevation for a raised appearance
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Set border radius
                  ),
                  child: ListTile(
                    title: Text(
                      data[index]['plate'].toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Set text color
                      ),
                    ),
                    onTap: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return SeatGrid(bus_id: data[index]['bus_id'], route_id: data[index]['routes']['route_id']);
                      }));
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
