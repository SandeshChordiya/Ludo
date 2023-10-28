import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ludo2/LudoWithGetx3Bots/3_bots_constants.dart';
import 'package:ludo2/LudoWithGetx3Bots/3_bots_controller.dart';
import 'package:ludo2/LudoWithGetx3Bots/3_bots_player.dart';
import 'package:ludo2/SoundsClass/audio.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

double boardSize(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  if (width > 500) {
    return 500;
  } else if (width < 300) {
    return 300;
  } else {
    return width - 50;
  }
}

double gridSize(BuildContext context) {
  return boardSize(context) / 15;
}

class LudoWith3BotsMainScreen extends StatefulWidget {
  const LudoWith3BotsMainScreen({super.key});

  @override
  State<LudoWith3BotsMainScreen> createState() =>
      _LudoWith3BotsMainScreenState();
}

class _LudoWith3BotsMainScreenState extends State<LudoWith3BotsMainScreen> {
  final LudoWith3BotsController controller = Get.put(LudoWith3BotsController());
  Timer? timer;
  Duration duration = Duration(minutes: 1);
  // Time

  startTimer({bool resets = true}) async {
    if (resets) {
      reset();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
    setState(() {});
  }

  void reset() {
    duration = Duration(minutes: 1);
    setState(() {});
  }

  void addTime() {
    setState(() {});
    final addSeconds = 1;

    final seconds = duration.inSeconds - addSeconds;

    duration = Duration(seconds: seconds);
  }

  void stopTimer({bool resets = true}) {
    setState(() {});
    if (resets) {
      reset();
    }
    timer?.cancel();
  }

  @override
  void initState() {
    super.initState();

    // startTimer();
    // reset();
    Audio.audioPlayer = AudioPlayer();
    time();
  }

  time() async {
    controller.startTimer();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    // For Checking Winner
    bool winners = false;

    // For time
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(10));
    String seconds = twoDigits(duration.inSeconds.remainder(60));

    if (int.parse(minutes) < 0 && int.parse(seconds) < 0) {
      setState(() {});
      print("Hello I am less than 0 minutes and 0 seconds");
      if (controller.sumRed >= controller.sumYellow &&
          controller.sumRed >= controller.greenSum &&
          controller.sumRed >= controller.sumblue) {
        setState(() {});
        controller.timer?.cancel();
        controller.won.add(LudoWith3BotsPlayer.red);
      } else if (controller.sumRed < controller.sumYellow &&
          controller.sumYellow > controller.greenSum &&
          controller.sumYellow > controller.sumblue) {
        setState(() {});
        controller.timer?.cancel();
        controller.won.add(LudoWith3BotsPlayer.yellow);
      } else if (controller.sumRed < controller.greenSum &&
          controller.sumYellow < controller.greenSum &&
          controller.greenSum > controller.sumblue) {
        setState(() {});
        controller.timer?.cancel();
        controller.won.add(LudoWith3BotsPlayer.green);
      } else if (controller.sumblue > controller.greenSum &&
          controller.sumYellow < controller.sumblue &&
          controller.sumRed < controller.sumblue) {
        setState(() {});
        controller.timer?.cancel();
        controller.won.add(LudoWith3BotsPlayer.blue);
      }
    }

    return Obx(() {
      if (controller.won.isNotEmpty) {
        winners = true;
      }
      return !winners
          ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/game screen images/2.png"),
                    fit: BoxFit.fill),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Center(
                    child: Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // For Timer
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: boardSize(context) * .08),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 0, 0, 0.4),
                                  ),
                                  child: Text(
                                    "$minutes : $seconds",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Green Player
                                controller.playerTurn == 4
                                    ? Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              right: boardSize(context) * .08,
                                              bottom: boardSize(context) * .03,
                                            ),
                                            padding: EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                left: 20,
                                                right: 20),
                                            decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.4),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              "Guest_5566",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    boardSize(context) * .04,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height:
                                                    boardSize(context) * .12,
                                                width: boardSize(context) * .12,
                                                child: controller
                                                    .playerTimer(context),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: boardSize(context) *
                                                        .03,
                                                    right: boardSize(context) *
                                                        .1),
                                                height: boardSize(context) * .1,
                                                width: boardSize(context) * .2,
                                                alignment: Alignment.topRight,
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2),
                                                ),
                                                // For Yellow Dice Widget
                                                child: Center(
                                                  child: SizedBox(
                                                    height:
                                                        boardSize(context) * .1,
                                                    width:
                                                        boardSize(context) * .1,
                                                    child: CompVsPlayerDice(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: boardSize(context) * .08,
                                                bottom:
                                                    boardSize(context) * .03),
                                            padding: EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                left: 20,
                                                right: 20),
                                            decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.4),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              "Guest_5566",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    boardSize(context) * .04,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height:
                                                    boardSize(context) * .12,
                                                width: boardSize(context) * .12,
                                                child: Image.asset(
                                                    "images/game screen images/human.png"),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: boardSize(context) *
                                                        .03,
                                                    right: boardSize(context) *
                                                        .1),
                                                height: boardSize(context) * .1,
                                                width: boardSize(context) * .2,
                                                alignment: Alignment.topRight,
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2),
                                                ),
                                                // For Yellow Dice Widget
                                                child: Center(
                                                  child: SizedBox(
                                                    height:
                                                        boardSize(context) * .1,
                                                    width:
                                                        boardSize(context) * .1,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                // Yellow Player
                                controller.playerTurn == 3
                                    ? Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: boardSize(context) * .08,
                                              bottom: boardSize(context) * .03,
                                            ),
                                            padding: EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                left: 20,
                                                right: 20),
                                            decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.4),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              "Guest_2266",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    boardSize(context) * .04,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: boardSize(context) *
                                                        .03,
                                                    left: boardSize(context) *
                                                        .1),
                                                height: boardSize(context) * .1,
                                                width: boardSize(context) * .2,
                                                alignment: Alignment.topRight,
                                                decoration: BoxDecoration(
                                                  color: Colors.yellow,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2),
                                                ),
                                                // For Yellow Dice Widget
                                                child: Center(
                                                  child: SizedBox(
                                                    height:
                                                        boardSize(context) * .1,
                                                    width:
                                                        boardSize(context) * .1,
                                                    child: CompVsPlayerDice(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    boardSize(context) * .12,
                                                width: boardSize(context) * .12,
                                                child: controller
                                                    .playerTimer(context),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: boardSize(context) * .08,
                                                bottom:
                                                    boardSize(context) * .03),
                                            padding: EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                left: 20,
                                                right: 20),
                                            decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.4),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              "Guest_2266",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    boardSize(context) * .04,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: boardSize(context) *
                                                        .03,
                                                    left: boardSize(context) *
                                                        .1),
                                                height: boardSize(context) * .1,
                                                width: boardSize(context) * .2,
                                                alignment: Alignment.topRight,
                                                decoration: BoxDecoration(
                                                  color: Colors.yellow,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2),
                                                ),
                                                // For Yellow Dice Widget
                                                child: Center(
                                                  child: SizedBox(
                                                    height:
                                                        boardSize(context) * .1,
                                                    width:
                                                        boardSize(context) * .1,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    boardSize(context) * .12,
                                                width: boardSize(context) * .12,
                                                child: Image.asset(
                                                    "images/game screen images/human.png"),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                            //
                            //
                            // Space for Board Widget
                            CompVsPlayerBoard(),
                            //
                            //Red Player Dice
                            //
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                controller.playerTurn == 1
                                    ? Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height:
                                                    boardSize(context) * .12,
                                                width: boardSize(context) * .12,
                                                child: controller
                                                    .playerTimer(context),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: boardSize(context) *
                                                        .03,
                                                    right: boardSize(context) *
                                                        .1),
                                                height: boardSize(context) * .1,
                                                width: boardSize(context) * .2,
                                                alignment: Alignment.bottomLeft,
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2),
                                                ),
                                                // For Red Dice Widget
                                                child: Center(
                                                  child: SizedBox(
                                                    height:
                                                        boardSize(context) * .1,
                                                    width:
                                                        boardSize(context) * .1,
                                                    child: CompVsPlayerDice(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: boardSize(context) * .08,
                                                top: boardSize(context) * .03),
                                            padding: EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                left: 20,
                                                right: 20),
                                            decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.4),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              "Guest_1654",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    boardSize(context) * .04,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height:
                                                    boardSize(context) * .12,
                                                width: boardSize(context) * .12,
                                                child: Image.asset(
                                                    "images/game screen images/human.png"),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: boardSize(context) *
                                                        .03,
                                                    right: boardSize(context) *
                                                        .1),
                                                height: boardSize(context) * .1,
                                                width: boardSize(context) * .2,
                                                alignment: Alignment.bottomLeft,
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2),
                                                ),
                                                // For Red Dice Widget
                                                child: Center(
                                                  child: SizedBox(
                                                    height:
                                                        boardSize(context) * .1,
                                                    width:
                                                        boardSize(context) * .1,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: boardSize(context) * .08,
                                                top: boardSize(context) * .03),
                                            padding: EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                left: 20,
                                                right: 20),
                                            decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.4),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              "Guest_1654",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    boardSize(context) * .04,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                // Blue Player
                                controller.playerTurn == 2
                                    ? Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: boardSize(context) *
                                                        .03,
                                                    left: boardSize(context) *
                                                        .1),
                                                height: boardSize(context) * .1,
                                                width: boardSize(context) * .2,
                                                alignment: Alignment.bottomLeft,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2),
                                                ),
                                                // For Red Dice Widget
                                                child: Center(
                                                  child: SizedBox(
                                                    height:
                                                        boardSize(context) * .1,
                                                    width:
                                                        boardSize(context) * .1,
                                                    child: CompVsPlayerDice(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    boardSize(context) * .12,
                                                width: boardSize(context) * .12,
                                                child: controller
                                                    .playerTimer(context),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: boardSize(context) * .08,
                                                top: boardSize(context) * .03),
                                            padding: EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                left: 20,
                                                right: 20),
                                            decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.4),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              "Guest_1654",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    boardSize(context) * .04,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: boardSize(context) *
                                                        .03,
                                                    left: boardSize(context) *
                                                        .1),
                                                height: boardSize(context) * .1,
                                                width: boardSize(context) * .2,
                                                alignment: Alignment.bottomLeft,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2),
                                                ),
                                                // For Red Dice Widget
                                                child: Center(
                                                  child: SizedBox(
                                                    height:
                                                        boardSize(context) * .1,
                                                    width:
                                                        boardSize(context) * .1,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    boardSize(context) * .12,
                                                width: boardSize(context) * .12,
                                                child: Image.asset(
                                                    "images/game screen images/human.png"),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: boardSize(context) * .08,
                                                top: boardSize(context) * .03),
                                            padding: EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                left: 20,
                                                right: 20),
                                            decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.4),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              "Guest_1654",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    boardSize(context) * .04,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/game screen images/2.png"),
                    fit: BoxFit.cover),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: controller.won[0] == LudoWith3BotsPlayer.yellow
                          ? Text(
                              "Yellow",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            )
                          : controller.won[0] == LudoWith3BotsPlayer.blue
                              ? Text(
                                  "Blue",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                )
                              : controller.won[0] == LudoWith3BotsPlayer.green
                                  ? Text(
                                      "Green",
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    )
                                  : SizedBox.shrink(),
                    ),
                    Center(
                      child: controller.won[1] == LudoWith3BotsPlayer.yellow
                          ? Text(
                              "Yellow",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            )
                          : controller.won[1] == LudoWith3BotsPlayer.blue
                              ? Text(
                                  "Blue",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                )
                              : controller.won[1] == LudoWith3BotsPlayer.green
                                  ? Text(
                                      "Green",
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    )
                                  : SizedBox.shrink(),
                    ),
                    Center(
                      child: controller.won[2] == LudoWith3BotsPlayer.yellow
                          ? Text(
                              "Yellow",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            )
                          : controller.won[2] == LudoWith3BotsPlayer.blue
                              ? Text(
                                  "Blue",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                )
                              : controller.won[2] == LudoWith3BotsPlayer.green
                                  ? Text(
                                      "Green",
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    )
                                  : SizedBox.shrink(),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Go back to main screen"),
                      ),
                    ),
                  ],
                ),
              ),
            );
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.stopTimer();
    // controller.dispose();
    super.dispose();
  }
}

// ///////////////////////////////////////////////////////////////////////
//
//
//
//
// Board Widget
//
//
//
//
// ///////////////////////////////////////////////////////////////////////

class CompVsPlayerBoard extends StatefulWidget {
  const CompVsPlayerBoard({super.key});

  @override
  State<CompVsPlayerBoard> createState() => _CompVsPlayerBoardState();
}

class _CompVsPlayerBoardState extends State<CompVsPlayerBoard> {
  final LudoWith3BotsController controller = Get.put(LudoWith3BotsController());
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.all(15),
        width: boardSize(context),
        height: boardSize(context),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Ludo Board/SS1.png"),
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Obx(() {
          print(
              "${controller.diceRoll}........${controller.isDiceRolling}.......${controller.gameState}.....${controller.forResponsive.value}");
          List<LudoWith3BotsPlayers> players = List.from(controller.players);
          Map<String, List<LudoWith3BotsPawn>> pawnRaw = {};
          Map<String, List<String>> pawnsToPrint = {};
          List<Widget> playerPawns = [];
          for (int i = 0; i < players.length; i++) {
            var player = players[i];
            for (int j = 0; j < player.pawns.length; j++) {
              var pawn = player.pawns[j];
              String movement = player.location[pawn.movement].toString();
              if (pawnRaw[movement] == null) {
                pawnRaw[movement] = [];
                pawnsToPrint[movement] = [];
              }
              pawnRaw[movement]!.add(pawn);
              pawnsToPrint[movement]!.add(player.colr.toString());
            }
          }

          for (int i = 0; i < pawnRaw.keys.length; i++) {
            String key = pawnRaw.keys.elementAt(i);
            List<LudoWith3BotsPawn> pawnValue = pawnRaw[key]!;
            List<double> coordinates = key
                .replaceAll("[", "")
                .replaceAll("]", "")
                .split(",")
                .map((e) => double.parse(e.trim()))
                .toList();

            if (pawnValue.length == 1) {
              var e = pawnValue.first;
              playerPawns.add(AnimatedPositioned(
                key: ValueKey("${e.col.name}_${e.number}"),
                duration: const Duration(milliseconds: 200),
                left: LudoWith3BotsPath.stepBox(
                    boardSize(context), coordinates[0]),
                top: LudoWith3BotsPath.stepBox(
                    boardSize(context), coordinates[1]),
                width: gridSize(context),
                height: gridSize(context),
                child: e,
              ));
            } else {
              playerPawns.addAll(List.generate(pawnValue.length, (index) {
                var e = pawnValue[index];
                return AnimatedPositioned(
                    key: ValueKey("${e.col.name}_${e.number}"),
                    duration: const Duration(milliseconds: 200),
                    left: LudoWith3BotsPath.stepBox(
                            boardSize(context), coordinates[0]) +
                        (index * 3),
                    top: LudoWith3BotsPath.stepBox(
                        boardSize(context), coordinates[1]),
                    width: gridSize(context),
                    height: gridSize(context),
                    child: e);
              }));
            }
            // }
          }
          return Center(
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                ...playerPawns,
                turnIndicator(context, controller.currentPlayer.colr,
                    controller.currentPlayer.color, controller.gameState),
                pawnMovementText(context),
                pawnGreenMovementText(context),
                pawnBlueMovementText(context),
                ...winners(context, controller.won),
              ],
            ),
          );
        }),
      ),
    ]);
  }

// Blue Player
  Widget pawnBlueMovementText(BuildContext context) {
    int x1 = 1;
    int y1 = 1;

    return Positioned(
      top: y1 == 0 ? 0 : null,
      left: x1 == 0 ? 0 : null,
      right: x1 == 1 ? 0 : null,
      bottom: y1 == 1 ? 0 : null,
      width: boardSize(context) * .4,
      height: boardSize(context) * .4,
      child: IgnorePointer(
        child: Container(
            margin: EdgeInsets.only(
              top: boardSize(context) * .09,
              right: boardSize(context) * .06,
            ),
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text: "${controller.sumblue}\n",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 14, 53, 86),
                  ),
                ),
              ]),
            )),
      ),
    );
  }

  // Green Player
  Widget pawnGreenMovementText(BuildContext context) {
    int x1 = 0;
    int y1 = 0;

    return Positioned(
      top: y1 == 0 ? 0 : null,
      left: x1 == 0 ? 0 : null,
      right: x1 == 1 ? 0 : null,
      bottom: y1 == 1 ? 0 : null,
      width: boardSize(context) * .4,
      height: boardSize(context) * .4,
      child: IgnorePointer(
        child: Container(
            margin: EdgeInsets.only(
              top: boardSize(context) * .09,
              right: boardSize(context) * .06,
            ),
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: "${controller.greenSum}\n",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 25, 108, 68))),
              ]),
            )),
      ),
    );
  }

// Yellow Player
  Widget pawnMovementText(BuildContext context) {
    int x1 = 1;
    int y1 = 0;

    return Positioned(
      top: y1 == 0 ? 0 : null,
      left: x1 == 0 ? 0 : null,
      right: x1 == 1 ? 0 : null,
      bottom: y1 == 1 ? 0 : null,
      width: boardSize(context) * .4,
      height: boardSize(context) * .4,
      child: IgnorePointer(
        child: Container(
            margin: EdgeInsets.only(
              top: boardSize(context) * .09,
              right: boardSize(context) * .06,
            ),
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: "${controller.sumYellow}\n",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber)),
              ]),
            )),
      ),
    );
  }

  // Red Player
  Widget turnIndicator(BuildContext context, LudoWith3BotsPlayer turn,
      Color color, LudoWith3BotsGameState stage) {
    //0 is left, 1 is right
    int x = 0;
    //0 is top, 1 is bottom
    int y = 1;

    return Positioned(
      top: y == 0 ? 0 : null,
      left: x == 0 ? 0 : null,
      right: x == 1 ? 0 : null,
      bottom: y == 1 ? 0 : null,
      width: boardSize(context) * .4,
      height: boardSize(context) * .4,
      child: IgnorePointer(
        child: Container(
          margin: EdgeInsets.only(
            top: boardSize(context) * .09,
            right: boardSize(context) * .06,
          ),
          alignment: Alignment.center,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(fontSize: 30, color: Colors.red),
              children: [
                // turn == DuoPlayerColor.red
                TextSpan(
                    text: "${controller.sumRed}\n",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> winners(
          BuildContext context, List<LudoWith3BotsPlayer> winners) =>
      List.generate(
        winners.length,
        (index) {
          //0 is left, 1 is right
          int x = 0;
          //0 is top, 1 is bottom
          int y = 0;

          switch (winners[index]) {
            case LudoWith3BotsPlayer.red:
              x = 0;
              y = 1;
              break;
            case LudoWith3BotsPlayer.blue:
              x = 1;
              y = 1;
              break;
            case LudoWith3BotsPlayer.yellow:
              x = 1;
              y = 0;
              break;
            case LudoWith3BotsPlayer.green:
              x = 0;
              y = 0;
              break;
          }
          // return Positioned(
          //   top: y == 0 ? 0 : null,
          //   left: x == 0 ? 0 : null,
          //   right: x == 1 ? 0 : null,
          //   bottom: y == 1 ? 0 : null,
          //   width: boardSize(context) * .4,
          //   height: boardSize(context) * .4,
          //   child: Container(
          //     child: ElevatedButton(
          //       onPressed: () {
          //         controller.stopTimer();
          //         // controller.onClose();
          //         // dispose();
          //         // controller.onDelete();
          //         // dispose();
          //         Get.back();
          //         // Get.to(() => WinningScreen());
          //         // Text("You Win");
          //       },
          //       child: Text("${winners[index]}"),
          //     ),
          //     // child: goToWinningScreen(),
          //   ),
          // );
          return Column(
            children: [
              Text(
                "${winners[0]},${winners[1]}, ${winners[2]}",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  backgroundColor: Colors.amberAccent,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Go Back to Main Screen"),
              ),
            ],
          );
        },
      );
}

// ///////////////////////////////////////////////////////////////////////
//
//
//
//
// Dice Widget
//
//
//
//
// ///////////////////////////////////////////////////////////////////////

class CompVsPlayerDice extends StatefulWidget {
  const CompVsPlayerDice({super.key});

  @override
  State<CompVsPlayerDice> createState() => _CompVsPlayerDiceState();
}

class _CompVsPlayerDiceState extends State<CompVsPlayerDice> {
  final LudoWith3BotsController controller = Get.put(LudoWith3BotsController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RippleAnimation(
        color: controller.gameState == LudoWith3BotsGameState.throwDice
            ? controller.currentPlayer.color
            : Colors.white.withOpacity(0),
        ripplesCount: 6,
        minRadius: 35,
        repeat: true,
        child: controller.computerTurn
            ? Container(
                child: controller.isDiceRolling
                    ? Image.asset("images/dice/draw.gif", fit: BoxFit.contain)
                    : Image.asset("images/dice/${controller.diceRoll}.png",
                        fit: BoxFit.contain),
              )
            : GestureDetector(
                onTap: controller.rollDice,
                child: controller.isDiceRolling
                    ? Image.asset("images/dice/draw.gif", fit: BoxFit.contain)
                    : Image.asset("images/dice/${controller.diceRoll}.png",
                        fit: BoxFit.contain),
              ),
      ),
    );
  }
}

// ///////////////////////////////////////////////////////////////////////
//
//
//
//
// Pawn Widget
//
//
//
//
// ///////////////////////////////////////////////////////////////////////

class LudoWith3BotsPawn extends StatefulWidget {
  final int number;
  final LudoWith3BotsPlayer col;
  final int movement;
  final bool isGlow;
  const LudoWith3BotsPawn(this.number, this.col,
      {Key? key, this.isGlow = false, this.movement = 0})
      : super(key: key);

  @override
  State<LudoWith3BotsPawn> createState() => _LudoWith3BotsPawnState();
}

class _LudoWith3BotsPawnState extends State<LudoWith3BotsPawn> {
  final LudoWith3BotsController controller = Get.put(LudoWith3BotsController());

  @override
  Widget build(BuildContext context) {
    int number = widget.number;
    int movement = widget.movement;
    RxBool isGlow = widget.isGlow.obs;
    LudoWith3BotsPlayer col = widget.col;
    Color color = Colors.white;
    switch (widget.col) {
      case LudoWith3BotsPlayer.red:
        color = LudoWith3BotsColor.red;
        break;
      case LudoWith3BotsPlayer.blue:
        color = LudoWith3BotsColor.blue;
        break;
      case LudoWith3BotsPlayer.yellow:
        color = LudoWith3BotsColor.yellow;
        break;
      case LudoWith3BotsPlayer.green:
        color = LudoWith3BotsColor.green;
        break;
    }
    return Obx(() {
      // print("${controller.computerTurn}");
      return IgnorePointer(
        ignoring: !isGlow.value,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isGlow.value)
              RippleAnimation(
                  color: color,
                  minRadius: 25,
                  repeat: true,
                  ripplesCount: 2,
                  child: const SizedBox.shrink()),
            GestureDetector(
              onTap: () {
                if (controller.currentPlayer.colr == LudoWith3BotsPlayer.red) {
                  if (widget.movement == -1) {
                    controller.move(col, number, (movement + 1) + 1);
                  } else {
                    controller.move(
                        col, number, (movement + 1) + controller.diceRoll);
                  }

                  Get.find<LudoWith3BotsController>()
                      .move(col, number, movement);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: color, width: 1.5)),
                child: Container(
                  decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5)),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
