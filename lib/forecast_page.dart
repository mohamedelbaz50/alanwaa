import 'dart:convert';

import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;

import 'components/forecast_row.dart';
import 'components/forecast_row_string.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  getData() async {
    var resp = await http
        .get(Uri.parse("${ConfigData.apiHost}/get_forecast.php"), headers: {
      "accept": "application/json",
    });
    if (resp.statusCode == 200) {
      var data = jsonDecode(resp.body);
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("تنبؤ جوي لهذا اليوم"),
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
                              "${ConfigData.dayOfWeek[DateTime.now().weekday - 1]} ${intl.DateFormat("yyyy/MM/dd", "ar").format(DateTime.now())}",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          const ForecastRowString(
                            name: "اسم\nالمحافظة",
                            status: "الحرارة الصغرى",
                            min: "الحرارة العظمى",
                            max: "الحالة الجوية",
                          ),
                          ...(snapshot.data! as List).map((e) => ForecastRow(
                              name: e['name'].toString(),
                              min: e["min"].toString(),
                              max: e["max"].toString(),
                              status: e['status'].toString(),
                              rain: e['rain'].toString())),
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
}
