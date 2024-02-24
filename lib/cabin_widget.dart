import 'package:flutter/material.dart';
import 'package:prestige_coach/custom_clipper.dart';
import 'package:prestige_coach/seat_widget.dart';

class CabinWidget extends StatelessWidget {
  const CabinWidget({
    super.key,
    required this.index,
    this.searchBarText,
  });

  final int index;
  final String? searchBarText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const SizedBox(
              height: 16,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipPath(
                      clipper: MyCustomCliperFromBottom(),
                      child: Container(
                        height: 60,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xff80CBFF),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          SeatWidget(
                            searchBarText: searchBarText,
                            seatIndex: 1 + index * 4,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          SeatWidget(
                            searchBarText: searchBarText,
                            seatIndex: 2 + index * 4,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          SeatWidget(
                            searchBarText: searchBarText,
                            seatIndex: 3 + index * 4,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          SeatWidget(
                            searchBarText: searchBarText,
                            seatIndex: 4 + index * 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 2),
      ],
    );
  }
}