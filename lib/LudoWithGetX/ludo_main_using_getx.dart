import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ludo2/LudoWithGetX/constants.dart';
import 'package:ludo2/LudoWithGetX/duo_player.dart';
import 'package:ludo2/LudoWithGetX/duo_controller.dart';
import 'package:ludo2/LudoWithGetX/winnning_screen.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

void goToWinningScreen() {
  Get.to(() => WinningScreen());
}

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

class LudoMain4 extends StatefulWidget {
  const LudoMain4({super.key});

  @override
  State<LudoMain4> createState() => _LudoMain4State();
}

class _LudoMain4State extends State<LudoMain4> {
  final CompVsPlayerController controller = Get.put(CompVsPlayerController());
  Timer? timer;
  Duration duration = Duration(minutes: 10);
  // Time

  startTimer({bool resets = true}) async {
    if (resets) {
      reset();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
    setState(() {});
    controller.forResponsive.value++;
  }

  void reset() {
    duration = Duration(minutes: 10);
    setState(() {});
    controller.forResponsive.value++;
  }

  void addTime() {
    setState(() {});
    controller.forResponsive.value++;
    final addSeconds = 1;

    final seconds = duration.inSeconds - addSeconds;

    duration = Duration(seconds: seconds);
  }

  void stopTimer({bool resets = true}) {
    // setState(() {});
    controller.forResponsive.value++;
    if (resets) {
      reset();
    }
    setState(() {
      timer?.cancel();
    });
  }

  @override
  void initState() {
    super.initState();

    // startTimer();
    // reset();
    time();
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

    if (int.parse(minutes) >= 10) {
      // setState(() {});
      controller.forResponsive.value++;
      if (controller.sumRed > controller.sumYellow) {
        // setState(() {});
        controller.forResponsive.value++;
        controller.timer?.cancel();
        controller.won.add(DuoPlayerColorVsComp.red);
      } else if (controller.sumRed < controller.sumRed) {
        // setState(() {});
        controller.forResponsive.value++;
        controller.timer?.cancel();
        controller.won.add(DuoPlayerColorVsComp.yellow);
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
                                  color: Color.fromRGBO(0, 0, 0, 0.4)),
                              child: Text(
                                "${minutes} : ${seconds}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        // Obx(() => ElevatedButton(
                        //     onPressed: () {
                        //       controller.rollDice();
                        //     },
                        //     child: Text(
                        //         "${controller.gameState}......${controller.currentPlayer.colr}....${controller.diceRoll}"))),

                        !controller.playerTurn
                            ? Column(
                                children: [
                                  controller.playerTimer(),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: boardSize(context) * .55,
                                      bottom: boardSize(context) * .03,
                                    ),
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
                                      "Guest_2266",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: boardSize(context) * .04,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: boardSize(context) * .03,
                                            left: boardSize(context) * .55),
                                        height: boardSize(context) * .1,
                                        width: boardSize(context) * .2,
                                        alignment: Alignment.topRight,
                                        decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
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
                                        child: Image.asset(
                                            "images/game screen images/human.png"),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: boardSize(context) * .55,
                                        bottom: boardSize(context) * .02),
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
                                      "Guest_2266",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: boardSize(context) * .04,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: boardSize(context) * .03,
                                            left: boardSize(context) * .55),
                                        height: boardSize(context) * .1,
                                        width: boardSize(context) * .2,
                                        alignment: Alignment.topRight,
                                        decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
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
                        //
                        //
                        // Space for Board Widget
                        CompVsPlayerBoard(),
                        //
                        //Red Player Dice
                        //
                        controller.playerTurn
                            ? Column(
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
                                  controller.playerTimer(),
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
    // controller.dispose();
    // controller.onClose();
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
  final CompVsPlayerController controller = Get.put(CompVsPlayerController());
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
          List<DuoPlayersVsComp> players = List.from(controller.players);
          Map<String, List<CompVsPlayerPawn>> pawnRaw = {};
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
              // } else {
              //   if (pawnRaw["home"] == null) {
              //     pawnRaw["home"] = [];
              //     pawnsToPrint["home"] = [];
              //   }
              //   pawnRaw["home"]!.add(pawn);
              //   pawnsToPrint["home"]!.add(player.colr.toString());
              // }
            }
          }

          for (int i = 0; i < pawnRaw.keys.length; i++) {
            String key = pawnRaw.keys.elementAt(i);
            List<CompVsPlayerPawn> pawnValue = pawnRaw[key]!;

            // if (key == "home") {
            //   playerPawns.addAll(pawnValue.map((e) {
            //     var player = controller.players
            //         .firstWhere((element) => element.colr == e.col);
            //     return AnimatedPositioned(
            //         key: ValueKey("${e.col.name}_${e.number}"),
            //         left: DuoPlayerPathVsComp.calcPawnsStep(
            //             boardSize(context), player.homeLocation[e.number][0]),
            //         top: DuoPlayerPathVsComp.calcPawnsStep(
            //             boardSize(context), player.homeLocation[e.number][1]),
            //         width: gridSize(context),
            //         height: gridSize(context),
            //         duration: const Duration(milliseconds: 200),
            //         child: e);
            //   }
            //   ));
            // } else {
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
                left: DuoPlayerPathVsComp.calcPawnsStep(
                    boardSize(context), coordinates[0]),
                top: DuoPlayerPathVsComp.calcPawnsStep(
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
                    left: DuoPlayerPathVsComp.calcPawnsStep(
                            boardSize(context), coordinates[0]) +
                        (index * 3),
                    top: DuoPlayerPathVsComp.calcPawnsStep(
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
              ],
            ),
          );
        }),
      ),
    ]);
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
  Widget turnIndicator(BuildContext context, DuoPlayerColorVsComp turn,
      Color color, DuoGameStateVsComp stage) {
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
          BuildContext context, List<DuoPlayerColorVsComp> winners) =>
      List.generate(
        winners.length,
        (index) {
          //0 is left, 1 is right
          int x = 0;
          //0 is top, 1 is bottom
          int y = 0;

          switch (winners[index]) {
            case DuoPlayerColorVsComp.red:
              x = 0;
              y = 1;
              break;
            case DuoPlayerColorVsComp.yellow:
              x = 1;
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
            child: Container(
              child: ElevatedButton(
                  onPressed: () {
                    print("Hello World");
                    controller.stopTimer();
                    // controller.onClose();
                    // dispose();
                    // controller.onDelete();
                    // dispose();
                    Get.back();
                    // Get.to(() => WinningScreen());
                    // Text("You Win");
                  },
                  child: Text("Game Over !")),
              // child: goToWinningScreen(),
            ),
          );
        },
      );
  // @override
  // void dispose() {
  //   controller.stopTimer();
  //   // controller.dispose();
  //   controller.onClose();
  //   controller.onDelete();
  //   super.dispose();
  // }
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
  final CompVsPlayerController controller = Get.put(CompVsPlayerController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RippleAnimation(
        color: controller.gameState == DuoGameStateVsComp.throwDice
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

class CompVsPlayerPawn extends StatefulWidget {
  final int number;
  final DuoPlayerColorVsComp col;
  final int movement;
  final bool isGlow;
  const CompVsPlayerPawn(this.number, this.col,
      {Key? key, this.isGlow = false, this.movement = 0})
      : super(key: key);

  @override
  State<CompVsPlayerPawn> createState() => _CompVsPlayerPawnState();
}

class _CompVsPlayerPawnState extends State<CompVsPlayerPawn> {
  final CompVsPlayerController controller = Get.put(CompVsPlayerController());

  @override
  Widget build(BuildContext context) {
    int number = widget.number;
    int movement = widget.movement;
    RxBool isGlow = widget.isGlow.obs;
    DuoPlayerColorVsComp col = widget.col;
    Color color = Colors.white;
    switch (widget.col) {
      case DuoPlayerColorVsComp.red:
        color = DuoColorsVsComp.red;
        break;
      case DuoPlayerColorVsComp.yellow:
        color = DuoColorsVsComp.yellow;
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
                if (controller.currentPlayer.colr == DuoPlayerColorVsComp.red) {
                  if (widget.movement == -1) {
                    controller.move(col, number, (movement + 1) + 1);
                  } else {
                    controller.move(
                        col, number, (movement + 1) + controller.diceRoll);
                  }

                  Get.find<CompVsPlayerController>()
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
