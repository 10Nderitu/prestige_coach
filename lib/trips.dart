import 'package:flutter/material.dart';
import 'package:prestige_coach/repository/repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Trips extends StatefulWidget {
  const Trips({Key? key}) : super(key: key);

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return Scaffold(
      body: FutureBuilder(
          future: Repository().getTrips(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transaction ID: ${data[index]['transaction_id']}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Start Location: ${data[index]['routes']['start_location']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            'End Location: ${data[index]['routes']['end_location']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Date: ${data[index]['date']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Seat Number: ${data[index]['seat_number']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Number Plate: ${data[index]['buses']['plate']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
          ),
    );
  }
}
