import 'package:flutter/material.dart';
import 'package:prestige_coach/payment.dart';
import 'package:prestige_coach/repository/repository.dart';

class SeatGrid extends StatefulWidget {

  final int bus_id;
  final int route_id;

  SeatGrid({super.key, required this.bus_id, required this.route_id});

  @override
  _SeatGridState createState() => _SeatGridState();
}

class _SeatGridState extends State<SeatGrid> {

  late BuildContext scaffoldContext;
  List<bool> selectedSeats = List.generate(16, (index) => false);

  int fare = 1500;
  int totalFare = 0;
  List<int> selectedSeatNumbers = [];

  @override
  void initState() {
    super.initState();
    // Store the context of the Scaffold
    scaffoldContext = context;
  }


  @override
  Widget build(BuildContext context) {
    int bus_id = widget.bus_id;
    int route_id = widget.route_id;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Text(
            style: TextStyle(fontWeight: FontWeight.bold), 'SELECT SEAT'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                builder: (context, snapshot) {
                  return GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: 16,
                    itemBuilder: (BuildContext context, int index) {
                      int row = index ~/ 4;
                      int col = index % 4;
                      bool isExcluded =
                          (row == 0 && col == 2) || (row == 2 && col == 1);
                      bool isBlack = row == 0 && col == 3;

                      bool isUnavailable = snapshot.data != null && snapshot.data!.any((seat) {
                        if (seat['seat_number'] is List) {
                          for (var seatIndex in seat['seat_number']) {
                            int index = int.parse(seatIndex) - 1;
                            int seatRow = index ~/ 4;
                            int seatCol = index % 4;
                            if (seatRow == row && seatCol == col) {
                              return true;
                            }
                          }
                          return false; // None of the seat numbers matched
                        }
                        return false; // Handle other cases if needed
                      });

                      return GestureDetector(
                        onTap: () {
                          if (!isExcluded && !isBlack && !isUnavailable) {
                            setState(() {
                              selectedSeats[index] = !selectedSeats[index];
                            });
                          }
                        },
                        child: Container(
                          color: isBlack
                              ? Colors.black
                              : isUnavailable
                              ? Colors.red
                              : isExcluded
                              ? Colors.transparent
                              : selectedSeats[index]
                              ? Colors.green
                              : Colors.blue,
                          margin: const EdgeInsets.all(8),
                        ),
                      );
                    },
                  );
                },
                future: Repository().getUnavailableSeats(
                    widget.bus_id, widget.route_id),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: () {
                  print(bus_id);
                  print(route_id);
                  setState(() {
                    totalFare = 0;
                    print(totalFare);
                    print(fare);
                    print(selectedSeatNumbers.length);
                  });
                  showSelectedSeatsDialog(
                      context, widget.route_id, widget.bus_id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Book Now',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void showSelectedSeatsDialog(BuildContext context, int route_id, int bus_id) {
    selectedSeatNumbers.clear();
    for (int i = 0; i < selectedSeats.length; i++) {
      if (selectedSeats[i]) {
        selectedSeatNumbers.add(i + 1);
        totalFare = fare * selectedSeatNumbers.length;
      }
    }

    showDialog(
      context: scaffoldContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(textAlign: TextAlign.center, 'Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(selectedSeatNumbers.isNotEmpty
                  ? 'Selected seat number(s): ${selectedSeatNumbers.join(', ')}'
                  : 'No seats selected', style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Text(
                'Total Fare: Ksh $totalFare',
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                if (selectedSeatNumbers.isEmpty) {
                  // Show Snackbar if no seats are selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No seats selected'),
                    ),
                  );
                } else {
                  await Repository().bookBus(
                      bus_id, route_id, selectedSeatNumbers);

                  await Navigator.pushReplacement(
                      scaffoldContext,
                      MaterialPageRoute(
                          builder: (context) => const Payment()));
                }
              },
              child: const Text(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  'Pay Now'),
            ),
          ],
        );
      },
    );
  }
}
