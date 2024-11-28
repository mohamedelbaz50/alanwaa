import 'package:flutter/material.dart';

class ForecastRowString extends StatelessWidget {
  const ForecastRowString(
      {super.key,
      required this.name,
      required this.status,
      required this.min,
      required this.max});
  final String name;
  final String status;
  final String min;
  final String max;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              status,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              min,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              max,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // SizedBox(
          //   width: 60,
          //   child: Text(
          //     rain,
          //     textAlign: TextAlign.center,
          //     style: const TextStyle(
          //       fontSize: 14,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
