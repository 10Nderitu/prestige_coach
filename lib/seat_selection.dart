import 'package:flutter/material.dart';
import 'package:prestige_coach/common_scaffold.dart';
import 'package:book_my_seat/book_my_seat.dart';

class SeatSelection extends StatefulWidget {
  const SeatSelection({super.key});

  @override
  State<SeatSelection> createState() => _SeatSelectionState();
}

class _SeatSelectionState extends State<SeatSelection> {
  Set<SeatNumber> selectedSeats = {};

  void _showSelectedSeatNumbers() {
    if (selectedSeats.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Selected Seat Numbers'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('You have selected the following seats:'),
                const SizedBox(height: 10),
                for (SeatNumber seatNumber in selectedSeats)
                  Text(seatNumber.toString()),
              ],
            ),
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
      // If no seats are selected, show a snack-bar with a message.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No seats selected.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: const Text('CHOOSE YOUR SEAT'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 50, horizontal: 100),
              child: SeatLayoutWidget(
                onSeatStateChanged: (rowI, colI, seatState) {
                  if (seatState == SeatState.selected) {
                    selectedSeats.add(SeatNumber(rowI: rowI, colI: colI));
                  } else {
                    selectedSeats.remove(SeatNumber(rowI: rowI, colI: colI));
                  }
                },
                stateModel: const SeatLayoutStateModel(
                  rows: 4,
                  cols: 4,
                  seatSvgSize: 50,
                  pathSelectedSeat: 'images/selected.svg',
                  pathDisabledSeat: 'images/disabled.svg',
                  pathSoldSeat: 'images/sold.svg',
                  pathUnSelectedSeat: 'images/available.svg',
                  currentSeatsState: [
                    [
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.empty,
                      SeatState.disabled,
                    ],
                    [
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.unselected,
                    ],
                    [
                      SeatState.unselected,
                      SeatState.empty,
                      SeatState.unselected,
                      SeatState.unselected,
                    ],
                    [
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.unselected,
                      SeatState.unselected,
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  Container(
                    width: 15,
                    height: 15,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 2),
                  const Text('Selected'),
                  const SizedBox(width: 10),
                  Container(
                    width: 15,
                    height: 15,
                    color: Colors.blue.shade200,
                  ),
                  const SizedBox(width: 2),
                  const Text('Available'),
                  const SizedBox(width: 10),
                  Container(
                    width: 15,
                    height: 15,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 2),
                  const Text('Sold'),
                  const SizedBox(width: 10),
                  Container(
                    width: 15,
                    height: 15,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 2),
                  const Text('Disabled'),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showSelectedSeatNumbers();
              },
              child: const Text('Show selected seat numbers'),
            ),
          ],
        ),
      ),
    );
  }
}

class SeatNumber {
  final int rowI;
  final int colI;

  const SeatNumber({required this.rowI, required this.colI});

  @override
  bool operator ==(Object other) {
    return rowI == (other as SeatNumber).rowI && colI == other.colI;
  }

  @override
  int get hashCode => rowI.hashCode;

  @override
  String toString() {
    return '[$rowI][$colI]';
  }
}
