import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChooseBus extends StatefulWidget {
  const ChooseBus({super.key});

  @override
  State<ChooseBus> createState() => _ChooseBusState();
}
class _ChooseBusState extends State<ChooseBus> {
  @override

  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Text('CHOOSE A VEHICLE'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: supabase.from('buses').select('plate'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Parse the snapshot data and display it
            final data = snapshot.data as List<dynamic>;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index]['plate'].toString()),
                );
              },
            );
          }
        },
      ),
    );
  }
}
