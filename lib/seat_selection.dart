import 'package:flutter/material.dart';

class SeatGrid extends StatefulWidget {
  @override
  _SeatGridState createState() => _SeatGridState();
}

class _SeatGridState extends State<SeatGrid> {
  List<bool> selectedSeats = List.generate(16, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Text('SELECT SEAT'),
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
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemCount: 16,
                itemBuilder: (BuildContext context, int index) {
                  int row = index ~/ 4;
                  int col = index % 4;
                  bool isExcluded = (row == 0 && col == 2) || (row == 2 && col == 1);
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
                      margin: const EdgeInsets.all(8.0),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  showSelectedSeatsDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Show Selected Seats',
                  style: TextStyle(
                    color: Colors.white,
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
    List<int> selectedSeatNumbers = [];

    for (int i = 0; i < selectedSeats.length; i++) {
      if (selectedSeats[i]) {
        selectedSeatNumbers.add(i + 1);
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selected Seats'),
          content: Text(selectedSeatNumbers.isNotEmpty ? selectedSeatNumbers.join(', ') : 'No seats selected'),
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
  }
}

