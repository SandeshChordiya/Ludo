import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ludo2/LudoWithGetx2Bots/2_bots_constants.dart';
import 'package:ludo2/LudoWithGetx2Bots/2_bots_controller.dart';
import 'package:ludo2/LudoWithGetx2Bots/2_bots_player.dart';
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

class LudoWith2BotsMainScreen extends StatefulWidget {
  const LudoWith2BotsMainScreen({super.key});

  @override
  State<LudoWith2BotsMainScreen> createState() =>
      _LudoWith2BotsMainScreenState();
}

class _LudoWith2BotsMainScreenState extends State<LudoWith2BotsMainScreen> {
  final LudoWith2BotsController controller = Get.put(LudoWith2BotsController());
  Timer? timer;
  Duration duration = Duration(minutes: 10);
  // Time

  startTimer({bool resets = true}) async {
    if (resets) {
      reset();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
    setState(() {});
  }

  void reset() {
    duration = Duration(minutes: 10);
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
    time();
    AudioPlayer audioPlayer = new AudioPlayer();
    Audio.audioPlayer = audioPlayer;
  }

  time() async {
    Future.delayed(Duration(seconds: 2)).then((value) {
      controller.startTimer();
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(10));
    String seconds = twoDigits(duration.inSeconds.remainder(60));

    if (int.parse(minutes) >= 0) {
      controller.forResponsive.value++;
      if (controller.sumRed > controller.sumYellow &&
          controller.sumRed > controller.greenSum) {
        controller.forResponsive.value++;
        controller.timer?.cancel();
        controller.won.add(LudoWith2BotsPlayer.red);
        if (controller.sumYellow > controller.greenSum) {
          controller.won.add(LudoWith2BotsPlayer.yellow);
        } else if (controller.sumYellow < controller.greenSum) {
          controller.won.add(LudoWith2BotsPlayer.green);
        }
      } else if (controller.sumRed < controller.sumYellow &&
          controller.sumYellow > controller.greenSum) {
        controller.forResponsive.value++;
        controller.timer?.cancel();
        controller.won.add(LudoWith2BotsPlayer.yellow);
        if (controller.greenSum > controller.sumRed) {
          controller.won.add(LudoWith2BotsPlayer.green);
        } else if (controller.sumRed > controller.greenSum) {
          controller.won.add(LudoWith2BotsPlayer.red);
        }
      } else if (controller.sumRed < controller.greenSum &&
          controller.sumYellow < controller.greenSum) {
        controller.forResponsive.value++;
        controller.timer?.cancel();
        controller.won.add(LudoWith2BotsPlayer.green);
        if (controller.sumRed > controller.sumYellow) {
          controller.won.add(LudoWith2BotsPlayer.red);
        } else if (controller.sumRed < controller.sumYellow) {
          controller.won.add(LudoWith2BotsPlayer.yellow);
        }
      }
    }

    return Container(
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
                Obx(
                  () => Container(
                    margin: EdgeInsets.only(
                      top: boardSize(context) * .1,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
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
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Green Player
                            controller.playerTurn == 3
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
                                          color: Color.fromRGBO(0, 0, 0, 0.4),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          "Guest_5566",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: boardSize(context) * .04,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: boardSize(context) * .12,
                                            width: boardSize(context) * .12,
                                            child:
                                                controller.playerTimer(context),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: boardSize(context) * .03,
                                                right: boardSize(context) * .1),
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
                                                height: boardSize(context) * .1,
                                                width: boardSize(context) * .1,
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
                                            bottom: boardSize(context) * .03),
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 20,
                                            right: 20),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(0, 0, 0, 0.4),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          "Guest_5566",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: boardSize(context) * .04,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: boardSize(context) * .12,
                                            width: boardSize(context) * .12,
                                            child: Image.asset(
                                                "images/game screen images/human.png"),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: boardSize(context) * .03,
                                                right: boardSize(context) * .1),
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
                                                height: boardSize(context) * .1,
                                                width: boardSize(context) * .1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                            // Yellow Player
                            controller.playerTurn == 2
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
                                          color: Color.fromRGBO(0, 0, 0, 0.4),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          "Guest_2266",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: boardSize(context) * .04,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: boardSize(context) * .03,
                                                left: boardSize(context) * .1),
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
                                                height: boardSize(context) * .1,
                                                width: boardSize(context) * .1,
                                                child: CompVsPlayerDice(),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: boardSize(context) * .12,
                                            width: boardSize(context) * .12,
                                            child:
                                                controller.playerTimer(context),
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
                                            bottom: boardSize(context) * .03),
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 20,
                                            right: 20),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(0, 0, 0, 0.4),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          "Guest_2266",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: boardSize(context) * .04,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: boardSize(context) * .03,
                                                left: boardSize(context) * .1),
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
                                                height: boardSize(context) * .1,
                                                width: boardSize(context) * .1,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: boardSize(context) * .12,
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
                        controller.playerTurn == 1
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: boardSize(context) * .12,
                                        width: boardSize(context) * .12,
                                        child: controller.playerTimer(context),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: boardSize(context) * .03,
                                            right: boardSize(context) * .55),
                                        height: boardSize(context) * .1,
                                        width: boardSize(context) * .2,
                                        alignment: Alignment.bottomLeft,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                        // For Red Dice Widget
                                        child: Center(
                                          child: SizedBox(
                                            height: boardSize(context) * .1,
                                            width: boardSize(context) * .1,
                                            child: CompVsPlayerDice(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: boardSize(context) * .55,
                                        top: boardSize(context) * .03),
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 20,
                                        right: 20),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 0, 0.4),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "Guest_1654",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: boardSize(context) * .04,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: boardSize(context) * .12,
                                        width: boardSize(context) * .12,
                                        child: Image.asset(
                                            "images/game screen images/human.png"),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: boardSize(context) * .03,
                                            right: boardSize(context) * .55),
                                        height: boardSize(context) * .1,
                                        width: boardSize(context) * .2,
                                        alignment: Alignment.bottomLeft,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                        // For Red Dice Widget
                                        child: Center(
                                          child: SizedBox(
                                            height: boardSize(context) * .1,
                                            width: boardSize(context) * .1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: boardSize(context) * .55,
                                        top: boardSize(context) * .03),
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 20,
                                        right: 20),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 0, 0.4),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "Guest_1654",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: boardSize(context) * .04,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // controller.won.length > 0
                        //     ? Container(
                        //         color: Colors.black.withOpacity(0.8),
                        //         child: Center(
                        //           child: Column(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: [
                        //               Image.asset("images/thankyou.gif"),
                        //               const Text("Thank you for playing 😙",
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontSize: 20),
                        //                   textAlign: TextAlign.center),
                        //               Text(
                        //                   "The Winners is: ${controller.won.map((e) => e.name.toUpperCase()).join(", ")}",
                        //                   style: const TextStyle(
                        //                       color: Colors.white,
                        //                       fontSize: 30),
                        //                   textAlign: TextAlign.center),
                        //               const Divider(color: Colors.white),
                        //               const Text(
                        //                   "This game made with Flutter ❤️ by Chedo Tech",
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontSize: 15),
                        //                   textAlign: TextAlign.center),
                        //               const SizedBox(height: 20),
                        //               const Text(
                        //                   "Refresh your mobile to play again",
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontSize: 10),
                        //                   textAlign: TextAlign.center),
                        //             ],
                        //           ),
                        //         ),
                        //       )
                        //     : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.stopTimer();
    Audio.audioPlayer.dispose();
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
  final LudoWith2BotsController controller = Get.put(LudoWith2BotsController());
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
          List<LudoWith2BotsPlayers> players = List.from(controller.players);
          Map<String, List<LudoWith2BotsPawn>> pawnRaw = {};
          Map<String, List<String>> pawnsToPrint = {};
          List<Widget> playerPawns = [];
          for (int i = 0; i < players.length; i++) {
            var player = players[i];
            for (int j = 0; j < player.pawns.length; j++) {
              var pawn = player.pawns[j];
              // if (pawn.movement > -1) {
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
            List<LudoWith2BotsPawn> pawnValue = pawnRaw[key]!;
            List<double> coordinates = key
                .replaceAll("[", "")
                .replaceAll("]", "")
                .split(",")
                .map((e) => double.parse(e.trim()))
                .toList();

            if (pawnValue.length == 1) {
              var e = pawnValue.first;
              print("${e.col.name} ...................... ${e.number}");
              playerPawns.add(AnimatedPositioned(
                key: ValueKey("${e.col.name}_${e.number}"),
                duration: const Duration(milliseconds: 200),
                left: LudoWith2BotsPath.stepBox(
                    boardSize(context), coordinates[0]),
                top: LudoWith2BotsPath.stepBox(
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
                    left: LudoWith2BotsPath.stepBox(
                            boardSize(context), coordinates[0]) +
                        (index * 3),
                    top: LudoWith2BotsPath.stepBox(
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
                ...winners(context, controller.won),
                turnIndicator(context, controller.currentPlayer.colr,
                    controller.currentPlayer.color, controller.gameState),
                pawnMovementText(context),
                pawnGreenMovementText(context),
              ],
            ),
          );
        }),
      ),
    ]);
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
  Widget turnIndicator(BuildContext context, LudoWith2BotsPlayer turn,
      Color color, LudoWith2BotsGameState stage) {
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
          BuildContext context, List<LudoWith2BotsPlayer> winners) =>
      List.generate(
        winners.length,
        (index) {
          //0 is left, 1 is right
          int x = 0;
          //0 is top, 1 is bottom
          int y = 0;

          switch (winners[index]) {
            case LudoWith2BotsPlayer.red:
              x = 0;
              y = 1;
              break;
            case LudoWith2BotsPlayer.yellow:
              x = 1;
              y = 0;
              break;
            case LudoWith2BotsPlayer.green:
              x = 0;
              y = 0;
              break;
          }
          return Positioned(
            top: y == 0 ? 0 : null,
            left: x == 0 ? 0 : null,
            right: x == 1 ? 0 : null,
            bottom: y == 1 ? 0 : null,
            width: boardSize(context) * .4,
            height: boardSize(context) * .4,
            child: ListView.builder(
              itemCount: winners.length,
              itemBuilder: (context, index) {
                // return Text("${winners[index]}");
              },
            ),
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
  final LudoWith2BotsController controller = Get.put(LudoWith2BotsController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RippleAnimation(
        color: controller.gameState == LudoWith2BotsGameState.throwDice
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

class LudoWith2BotsPawn extends StatefulWidget {
  final int number;
  final LudoWith2BotsPlayer col;
  final int movement;
  final bool isGlow;
  const LudoWith2BotsPawn(this.number, this.col,
      {Key? key, this.isGlow = false, this.movement = 0})
      : super(key: key);

  @override
  State<LudoWith2BotsPawn> createState() => _LudoWith2BotsPawnState();
}

class _LudoWith2BotsPawnState extends State<LudoWith2BotsPawn> {
  final LudoWith2BotsController controller = Get.put(LudoWith2BotsController());

  @override
  Widget build(BuildContext context) {
    int number = widget.number;
    int movement = widget.movement;
    RxBool isGlow = widget.isGlow.obs;
    LudoWith2BotsPlayer col = widget.col;
    Color color = Colors.white;
    switch (widget.col) {
      case LudoWith2BotsPlayer.red:
        color = LudoWith2BotsColor.red;
        break;
      case LudoWith2BotsPlayer.yellow:
        color = LudoWith2BotsColor.yellow;
        break;
      case LudoWith2BotsPlayer.green:
        color = LudoWith2BotsColor.green;
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
                if (controller.currentPlayer.colr == LudoWith2BotsPlayer.red) {
                  if (widget.movement == -1) {
                    controller.move(col, number, (movement + 1) + 1);
                  } else {
                    controller.move(
                        col, number, (movement + 1) + controller.diceRoll);
                  }

                  Get.find<LudoWith2BotsController>()
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
