import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ludo2/LudoWithGetx3Bots/ludo_with_3_bots_main_screen.dart';
import 'package:ludo2/ludo_login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LudoWith3BotsMainScreen(),
    );
  }
}
