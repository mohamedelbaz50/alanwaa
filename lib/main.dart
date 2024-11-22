import 'dart:io';
import 'package:app/firebase_options.dart';
import 'package:app/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'home_page.dart';4

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  HttpOverrides.global = MyHttpGlobals();
  runApp(const MyApp());
}

class MyHttpGlobals extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = ((cert, host, port) => true);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'الانواء الجوية',
      debugShowCheckedModeBanner: false,
      locale: const Locale("ar"),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        // useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class ConfigData {
  static const String apiHost = "https://metological-iraq.online/weather";
  // static const String apiHost = "http://localhost:8080";
  // static const String apiHost = "http://10.0.2.2:8080";
  static const Color lightbg = Color(0x40ffffff);
  static const List<String> dayOfWeek = [
    'الاثنين',
    'الثلاثاء',
    'الاربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الاحد',
  ];
  static String formatDate(DateTime date) {
    var day = formatNumber(date.day, 2);
    var month = formatNumber(date.month, 2);
    var year = formatNumber(date.year, 4);

    return "$day/$month/$year";
  }

  static String formatNumber(int number, int len) {
    int lenDiff = len - number.toString().length;
    return number.toString().padLeft(lenDiff, '0');
  }
}
