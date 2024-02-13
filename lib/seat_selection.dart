import 'package:flutter/material.dart';

class SeatSelection extends StatefulWidget {
  const SeatSelection({super.key});

  @override
  State<SeatSelection> createState() => _SeatSelectionState();
}

class _SeatSelectionState extends State<SeatSelection> {
  List<List<bool>> seatStatus = [
    [false, false, false, false],
    [false, false, false, false],
    [false, false, false, false],
    [false, false, false, false],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Text('BOOK YOUR SEATS'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Select your seat:',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 500,
            child: Column(
              children: List.generate(
                seatStatus.length,
                    (rowIndex) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    seatStatus[rowIndex].length,
                        (colIndex) {
                      // Check if it's square number 2 or 11
                      bool isSquareNumber2Or11 =
                          (rowIndex * seatStatus[rowIndex].length) +
                              seatStatus[rowIndex].length -
                              colIndex ==
                              2 ||
                              (rowIndex * seatStatus[rowIndex].length) +
                                  seatStatus[rowIndex].length -
                                  colIndex ==
                                  11;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            seatStatus[rowIndex][colIndex] =
                            !seatStatus[rowIndex][colIndex];
                          });
                        },
                        child: Opacity(
                          opacity: isSquareNumber2Or11 ? 0.0 : 1.0,
                          child: Container(
                            width: 50,
                            height: 70,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: seatStatus[rowIndex][colIndex]
                                  ? Colors.red
                                  : Colors.green,
                              border: Border.all(),
                            ),
                            child: Center(
                              child: Text(
                                '${(rowIndex * seatStatus[rowIndex].length) + seatStatus[rowIndex].length - colIndex}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
