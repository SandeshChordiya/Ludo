import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ludo2/LudoWithGetX/ludo_main_page.dart';

class WinningScreen extends StatefulWidget {
  const WinningScreen({super.key});

  @override
  State<WinningScreen> createState() => _WinningScreenState();
}

class _WinningScreenState extends State<WinningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 155, 93, 93).withOpacity(1.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("images/thankyou.gif"),
              const Text("Thank you for playing 😙",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center),
              Text("The Winners is:",
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                  textAlign: TextAlign.center),
              const Divider(color: Colors.white),
              const Text("This game made by Chedo",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => LudoHomePage());
                },
                child: Text("Go Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
