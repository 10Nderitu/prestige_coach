import 'package:flutter/material.dart';
import 'package:prestige_coach/repository/repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Trips extends StatefulWidget {
  const Trips({Key? key}) : super(key: key);

  // final String start_location;
  // final String end_location;

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
  }

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trips'),
      ),
      // body: FutureBuilder(future: Repository().getTransactions(widget.start_location, widget.end_location),
      //     builder: (context, snapshot){
      //   final data = snapshot.data!;
      //   return Center(child: Text('Error: ${snapshot.error}'));
      //     }),
    );
  }
}
