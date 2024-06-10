import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../theme/theme.dart';
import '../screens/home_screen.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundColor,
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
