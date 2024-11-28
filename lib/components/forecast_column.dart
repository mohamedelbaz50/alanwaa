import 'package:flutter/material.dart';

class ForecastColumn extends StatelessWidget {
  const ForecastColumn(
      {super.key,
      required this.name,
      required this.status,
      required this.min,
      required this.max,
      required this.rain});
  final String name;
  final String status;
  final String min;
  final String max;
  final String rain;

  @override
  Widget build(BuildContext context) {
     final minTemp = num.tryParse(min) ?? 0;
    final maxTemp = num.tryParse(max) ?? 0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.blue[200],
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            const SizedBox(height: 30.0),
            Image.asset(
              "assets/icons/$status.png",
              width: 60,
            ),
            const SizedBox(height: 30.0),
            Text(
              max,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: maxTemp > 48 ? Colors.red : Colors.black,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              min,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: minTemp > 48 ? Colors.red : Colors.black,
              ),
            ),
            const SizedBox(height: 4.0),
            const Text(
              "كمية المطر",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // const SizedBox(height: 4.0),
            Text(
              rain,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
