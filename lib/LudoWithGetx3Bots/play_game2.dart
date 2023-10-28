import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:ludo2/LudoWithGetx2Bots/play_game3.dart';
import 'package:ludo2/LudoWithGetx2Bots/tile3.dart';
import 'package:ludo2/LudoWithGetx3Bots/tile2.dart';
import 'package:ludo2/PlayGame.dart';
import 'package:ludo2/Tile.dart';

class PlayGame2 extends StatefulWidget {
  const PlayGame2({super.key});

  @override
  State<PlayGame2> createState() => _PlayGame2State();
}

class _PlayGame2State extends State<PlayGame2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 31, 14, 118),
          body: Column(
            children: [
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    Container(
                      // height: 280,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .2,
                                top: MediaQuery.of(context).size.width * .03),
                            child: Image.asset(
                              "images/ludo logo/Super Ludo Gold.png",
                              scale: 4.5,
                            ),
                          ),
                          Positioned(
                              top: 20,
                              left: 30,
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 17,
                                color: Colors.white,
                              )),
                          Positioned(
                              top: 20,
                              right: 90,
                              child: Icon(
                                Icons.help_outline,
                                size: 19,
                                color: Colors.white,
                              )),
                          Positioned(
                            top: 15,
                            right: 10,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                width: 70,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "9.0",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.purple,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Icon(
                                        Icons.add_circle,
                                        size: 20,
                                        color: Colors.purple,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        top: 200,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          //  margin: EdgeInsets.only(top: 50),
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                    color: Colors.grey[100]),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 50),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10, left: 20),
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Icon(Icons
                                                        .more_horiz_outlined),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20, left: 10),
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: 45,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 15),
                                                      child: Text(
                                                        "All",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: InkWell(
                                                  child: Container(
                                                    width: 60,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 10),
                                                      child: Text(
                                                        "QUICK",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.to(() => PlayGame());
                                                  },
                                                  child: Container(
                                                    width: 110,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 10),
                                                      child: Text(
                                                        "4 Player.3 Winner",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.to(() => PlayGame3());
                                                  },
                                                  child: Container(
                                                    width: 110,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 12),
                                                      child: Text(
                                                        "2 Player.1 Winner",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, right: 80, bottom: 20),
                                child: Text(
                                  "Recommended Tournaments",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: SizedBox(
                                  height: 280,
                                  child: Tile2(),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
