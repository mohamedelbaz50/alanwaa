import 'dart:convert';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForecastTwoPage extends StatefulWidget {
  const ForecastTwoPage({super.key});

  @override
  State<ForecastTwoPage> createState() => _ForecastTwoPageState();
}

class _ForecastTwoPageState extends State<ForecastTwoPage> {
  getData() async {
    var resp = await http
        .get(Uri.parse("${ConfigData.apiHost}/get_forecast2.php"), headers: {
      "accept": "application/json",
    });
    if (resp.statusCode == 200) {
      var data = jsonDecode(resp.body);
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now().add(const Duration(days: 1));
    return Scaffold(
        appBar: AppBar(
          title: const Text("تنبؤ جوي ليومين"),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: ConfigData.lightbg,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        children: [
                          Center(
                            child: Text(
                              "${ConfigData.dayOfWeek[date.weekday - 1]} ${ConfigData.formatDate(date)}",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          _forecastRowString(
                              "اسم\nالمحافظة",
                              "الحرارة الصغرى",
                              "الحرارة العظمى",
                              "الحالة الجوية",
                              "كمية الامطار"),
                          ...(snapshot.data! as List).map((e) => _forecastRow(
                              e['name'],
                              e["min"],
                              e["max"],
                              e['status'],
                              e['rain'])),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget _forecastRow(
      String name, String min, String max, String status, String rain) {
    assert(min.isNotEmpty);
    assert(max.isNotEmpty);
    assert(status.isNotEmpty);
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
            height: 50,
          ),
          // const SizedBox(width: 16.0),
          SizedBox(
            width: 50,
            child: Text(
              "$min°",
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: num.parse(min) > 48 ? Colors.red : Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 50,
            child: Text(
              "$max°",
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: num.parse(max) > 48 ? Colors.red : Colors.black,
              ),
            ),
          ),

          SizedBox(
            width: 50,
            child: Text(
              rain,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _forecastRowString(
      String name, String min, String max, String status, String rain) {
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
            width: 50,
            child: Text(
              status,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 50,
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
            width: 50,
            child: Text(
              max,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 50,
            child: Text(
              rain,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
