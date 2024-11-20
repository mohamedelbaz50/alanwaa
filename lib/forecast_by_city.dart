import 'dart:convert';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForecastByCity extends StatefulWidget {
  const ForecastByCity({super.key});

  @override
  State<ForecastByCity> createState() => _ForecastByCityState();
}

class _ForecastByCityState extends State<ForecastByCity> {
  String? selectedValue;
  var data = [];
  var filteredData = [];
  bool isLoading = false;
  getData() async {
    data.clear();
    setState(() {
      isLoading = true;
    });
    var resp = await http
        .get(Uri.parse("${ConfigData.apiHost}/get_forecast.php"), headers: {
      "accept": "application/json",
    });
    if (resp.statusCode == 200) {
      data = jsonDecode(resp.body);
      // return data;
    }
    resp = await http
        .get(Uri.parse("${ConfigData.apiHost}/get_forecast2.php"), headers: {
      "accept": "application/json",
    });
    if (resp.statusCode == 200) {
      data.addAll(jsonDecode(resp.body));
      // return data;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var names = Set<String>.from(data.map((e) => e['name'])).toList();
    if (selectedValue != null) {
      filteredData =
          data.where((element) => element['name'] == selectedValue).toList();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("اختر المدينة"),
        centerTitle: true,
      ),
      body: isLoading
          ? _loadingWidget()
          : Container(
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
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(children: [
                        Text(
                          "${ConfigData.dayOfWeek[DateTime.now().weekday - 1]} ${ConfigData.formatDate(DateTime.now())}",
                          style: const TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 50,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              ...names.map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: ChoiceChip(
                                      label: Text(e),
                                      selected: selectedValue == e,
                                      onSelected: (value) {
                                        setState(() {
                                          selectedValue = e;
                                        });
                                      },
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   width: 250,
                        //   child: DropdownButton<String>(
                        //       style: const TextStyle(
                        //           fontSize: 30, color: Colors.black),
                        //       isExpanded: true,
                        //       value: selectedValue,
                        //       items: names
                        //           .map((e) => DropdownMenuItem<String>(
                        //               value: e, child: Text(e)))
                        //           .toList(),
                        //       onChanged: (val) {
                        //         setState(() {
                        //           selectedValue = val;
                        //         });
                        //       }),
                        // ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            selectedValue ?? "",
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...filteredData.asMap().entries.map((e) =>
                                _forecastColumn(
                                    ConfigData.dayOfWeek[DateTime.now()
                                            .add(Duration(days: e.key))
                                            .weekday -
                                        1],
                                    e.value['max'],
                                    e.value['min'],
                                    e.value['status'],
                                    e.value['rain']))
                          ],
                        ),
                        Expanded(
                          child: Container(),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _forecastColumn(
      String name, String max, String min, String status, String rain) {
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
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: num.parse(max) > 48 ? Colors.red : Colors.black,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              min,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: num.parse(min) > 48 ? Colors.red : Colors.black,
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
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}