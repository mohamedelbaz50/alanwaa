import 'dart:convert';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getData() async {
    var resp = await http
        .get(Uri.parse("${ConfigData.apiHost}/get_images.php"), headers: {
      "accept": "application/json",
    });
    if (resp.statusCode == 200) {
      var data = jsonDecode(resp.body);
      // print(data);
      return data;
    }
  }

  // var _scale = 1.0;
  // var _prevScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("النشرة الجوية"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return InteractiveViewer(
                constrained: false,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...(snapshot.data! as List)
                          .map((e) => Image.network("${ConfigData.apiHost}/$e"))
                    ],
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
