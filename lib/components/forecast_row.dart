import 'package:flutter/material.dart';

class ForecastRow extends StatelessWidget {
  const ForecastRow(
      {super.key,
      required this.name,
      required this.min,
      required this.max,
      required this.status,
      required this.rain});
  final String name;
  final String min;
  final String max;
  final String status;
  final String rain;

  @override
  Widget build(BuildContext context) {
    final minTemp = num.tryParse(min) ?? 0;
    final maxTemp = num.tryParse(max) ?? 0;

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Image.asset(
            "assets/icons/$status.png",
            height: 70,
            // width:70,
          ),
          // const SizedBox(width: 16.0),
          SizedBox(
            width: 70,
            child: Text(
              "$minTemp°",
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: minTemp > 48 ? Colors.red : Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              "$maxTemp°",
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: maxTemp > 48 ? Colors.red : Colors.black,
              ),
            ),
          ),

          // SizedBox(
          //   width: 60,
          //   child: Text(
          //     rain,
          //     textAlign: TextAlign.center,
          //     style: const TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
