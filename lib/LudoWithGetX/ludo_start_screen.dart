import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ludo2/LudoWithGetX/ludo_main_page.dart';
import 'package:ludo2/PlayGame.dart';

class LudoStartScreenPage extends StatefulWidget {
  const LudoStartScreenPage({super.key});

  @override
  State<LudoStartScreenPage> createState() => _LudoStartScreenPageState();
}

class _LudoStartScreenPageState extends State<LudoStartScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 170, 1),
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Get.to(() => PlayGame());
                  },
                  label: Text("Next Page"),
                  icon: Icon(Icons.arrow_forward),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color.fromRGBO(0, 0, 0, 0.4)),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .03),
                child: Image.asset(
                  "images/ludo logo/Super Ludo Gold.png",
                  scale: 3.5,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .23,
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * .03),
                        child: Image.asset(
                          "images/main screen icons/5 play button.png",
                          scale: 30,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * .02,
                      ),
                      Text(
                        "   INSTANT \nWITHDRAWAL",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * .03),
                        child: Image.asset(
                          "images/main screen icons/7 Resume Button.png",
                          scale: 35,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * .02,
                      ),
                      Text(
                        "100% SAFE\nPAYMENTS",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * .03),
                        child: Image.asset(
                          "images/main screen icons/8 Restart Button.png",
                          scale: 36,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * .02,
                      ),
                      Text(
                        " NO BOTS \nALLOWED",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * .03),
                        child: Image.asset(
                          "images/main screen icons/10 option.png",
                          scale: 35,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * .02,
                      ),
                      Text(
                        "        RNG \nCERTIFICATE",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * .1,
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    "MADE IN INDIA",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        wordSpacing: 3,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * .02,
                  ),
                  Text(
                    "www.superludogold.com",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        wordSpacing: 5,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
