import 'package:flutter/material.dart';
import 'package:prestige_coach/payment.dart';

class SeatGrid extends StatefulWidget {
  @override
  _SeatGridState createState() => _SeatGridState();
}

class _SeatGridState extends State<SeatGrid> {
  List<bool> selectedSeats = List.generate(16, (index) => false);

  int fare = 1500;
  int totalFare = 0;
  List<int> selectedSeatNumbers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Text(style: TextStyle(fontWeight: FontWeight.bold),'SELECT SEAT'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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

                  return GestureDetector(
                    onTap: () {
                      if (!isExcluded && !isBlack) {
                        setState(() {
                          selectedSeats[index] = !selectedSeats[index];
                        });
                      }
                    },
                    child: Container(
                      color: isBlack
                          ? Colors.black
                          : isExcluded
                              ? Colors.transparent
                              : selectedSeats[index]
                                  ? Colors.green
                                  : Colors.blue,
                      margin: const EdgeInsets.all(8),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    totalFare = 0;
                    print(totalFare);
                    print(fare);
                    print(selectedSeatNumbers.length);
                  });
                  showSelectedSeatsDialog();
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

  void showSelectedSeatsDialog() {
    selectedSeatNumbers.clear();
    for (int i = 0; i < selectedSeats.length; i++) {
      if (selectedSeats[i]) {
        selectedSeatNumbers.add(i + 1);
        totalFare = fare * selectedSeatNumbers.length;
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(textAlign: TextAlign.center, 'Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(selectedSeatNumbers.isNotEmpty
                  ? 'Selected seat number(s): ${selectedSeatNumbers.join(', ')}'
                  : 'No seats selected', style: const TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Text(
                'Total Fare: Ksh $totalFare',
                style: const TextStyle(fontSize:20, fontWeight: FontWeight.bold),
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
                  // initiate payment
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Payment()));
                }
              },
              child: const Text(style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), 'Pay Now'),
            ),
          ],
        );
      },
    );
  }

}
