import 'package:app/forecast_by_city.dart';
import 'package:app/forecast_page.dart';
import 'package:app/forecast_two_page.dart';
import 'package:app/home_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:locally/locally.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static Future<void> onBack(RemoteMessage m) async {
    // print(m.notification!.title);
  }

  @override
  void initState() {
    var locally = Locally(
        context: context,
        payload: "test",
        appIcon: 'mipmap/ic_launcher',
        pageRoute: MaterialPageRoute(
          builder: (context) => const MainPage(),
        ));
    var messaging = FirebaseMessaging.instance;
    messaging.requestPermission().then((value) {
      messaging.getToken().then((value) {});
    });
    messaging.subscribeToTopic('weahter-forecast');
    FirebaseMessaging.onMessage.listen((event) {
      locally.show(
          title: event.notification!.title, message: event.notification!.body);
    });
    FirebaseMessaging.onBackgroundMessage(onBack);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/logo.png",
                          width: 300,
                        ),
                        const SizedBox(height: 8.0),
                        _elevatedButton(() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const HomePage()));
                        }, "النشرة الجوية"),
                        _elevatedButton(() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const ForecastPage()));
                        }, "تنبؤ جوي لهذا اليوم"),
                        _elevatedButton(() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const ForecastTwoPage()));
                        }, "تنبؤ جوي ليوم غدا"),
                        _elevatedButton(() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const ForecastByCity()));
                        }, "اختر المدينة"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Eng samer shuaa 2024 "),
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton _elevatedButton(Function()? onPressed, String text) {
    return ElevatedButton(
        style: const ButtonStyle(
            fixedSize: MaterialStatePropertyAll(Size(250, 40))),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ));
  }
}
