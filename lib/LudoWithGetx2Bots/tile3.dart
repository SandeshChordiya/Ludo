import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ludo2/LudoWithGetX/ludo_main_using_getx.dart';
import 'package:ludo2/LudoWithGetx2Bots/ludo_with_getx_2_bots_main_screen.dart';

class Tile3 extends StatefulWidget {
  const Tile3({super.key});

  @override
  State<Tile3> createState() => _Tile3State();
}

class _Tile3State extends State<Tile3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 320,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.supervised_user_circle,
                          size: 17,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text(
                          "378",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 55),
                        child: Text(
                          "2 PLAYERS",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          ".",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "1 WINNER",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 320,
                  height: 110,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 40, top: 10),
                              child: Text(
                                "PRIZE POOL",
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 150, top: 10),
                              child: Text(
                                "ENTRY",
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 90,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[300]),
                              child: Center(
                                child: Text(
                                  "RS0.6",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 65,
                              height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[300]),
                              child: Center(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Icon(
                                      Icons.timer,
                                      size: 12,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "OM:49S",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 90,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey),
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => LudoMain4());
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                child: Text("FREE")),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 320,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.supervised_user_circle,
                          size: 17,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text(
                          "10",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 55),
                        child: Text(
                          "2 PLAYERS",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          ".",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "1 WINNER",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 320,
                  height: 110,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 40, top: 10),
                              child: Text(
                                "PRIZE POOL",
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 150, top: 10),
                              child: Text(
                                "ENTRY",
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 90,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[300]),
                              child: Center(
                                child: Text(
                                  "RS17",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 65,
                              height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[300]),
                              child: Center(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Icon(
                                      Icons.timer,
                                      size: 12,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "OM:49S",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 90,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey),
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.yellow,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                child: Text(
                                  "5",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                //3
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 320,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.supervised_user_circle,
                          size: 17,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text(
                          "80",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 55),
                        child: Text(
                          "2 PLAYERS",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          ".",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "1 WINNER",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 320,
                  height: 110,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 40, top: 10),
                              child: Text(
                                "PRIZE POOL",
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 150, top: 10),
                              child: Text(
                                "ENTRY",
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 90,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[300]),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, left: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      "RS1.7",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 65,
                              height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[300]),
                              child: Center(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Icon(
                                      Icons.timer,
                                      size: 12,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "OM:49S",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 90,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey),
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.yellow,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
