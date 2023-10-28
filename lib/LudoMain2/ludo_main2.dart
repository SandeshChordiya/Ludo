import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

//
//
//
// Starting of Provider Functions
//
//
//

DuoPlayerColorVsComp candy = DuoPlayerColorVsComp.red;
int index1 = 0;
int movement1 = 0;

bool _playerTurn = true;
bool get playerTurn => _playerTurn;

int six = 0;

bool _computerTurn = false;
bool get computerTurn => _computerTurn;

bool _isTravelling = false;

final bool _stopTravelling = false;

DuoGameStateVsComp _gameState = DuoGameStateVsComp.throwDice;

DuoGameStateVsComp get gamestate => _gameState;

DuoPlayerColorVsComp _currentColor = DuoPlayerColorVsComp.red;

// Sum of red Pawns
int get sumRed {
  int trialsum = 0;
  for (int i = 0; i < player(DuoPlayerColorVsComp.red).pawns.length; i++) {
    trialsum += player(DuoPlayerColorVsComp.red).pawns[i].movement + 1;
  }
  return trialsum;
}

int get sumYellow {
  int trialsum = 0;
  for (int i = 0; i < player(DuoPlayerColorVsComp.yellow).pawns.length; i++) {
    trialsum += player(DuoPlayerColorVsComp.yellow).pawns[i].movement + 1;
  }
  return trialsum;
}

int _diceRoll = 0;

int get diceRoll {
  if (_diceRoll < 1) {
    return 1;
  } else if (_diceRoll > 6) {
    return 6;
  } else {
    return _diceRoll;
  }
}

bool _isDiceRolling = false;
bool get isDiceRolling => _isDiceRolling;

final List<DuoPlayersVsComp> players = [
  DuoPlayersVsComp(DuoPlayerColorVsComp.red),
  DuoPlayersVsComp(DuoPlayerColorVsComp.yellow)
];

DuoPlayersVsComp get currentPlayer =>
    players.firstWhere((element) => element.colr == _currentColor);

List<int> get maxPawnMovement =>
    currentPlayer.pawns.map((e) => e.movement).toList();

final List<DuoPlayerColorVsComp> won = [];

DuoPlayersVsComp player(DuoPlayerColorVsComp col) =>
    players.firstWhere((element) => element.colr == col);

void rollDice() async {
  // stopTimer();
  int delay = 0;
  if (currentPlayer.colr == DuoPlayerColorVsComp.yellow) {
    int rand = Random().nextInt(2) + 1;
    delay = rand;
  } else {
    delay = 0;
  }
  // Delay for Dice move
  Future.delayed(Duration(seconds: delay)).then((value) {
    if (_gameState != DuoGameStateVsComp.throwDice) return;

    _isDiceRolling = true;
    // setState(() {});
    // notifyListeners();
    // Audio.rollDice();

    currentPlayer.allGlowingPawns(false);

    Future.delayed(const Duration(seconds: 1)).then((value) async {
      _isDiceRolling = false;
      // notifyListeners();
      // setState(() {});
      var random = Random();
      _diceRoll = random.nextInt(6) + 1;

      if (_diceRoll == 6) {
        six++;
        if (six == 3) {
          nextTurn();
          return;
        }
      }

      if (diceRoll == 6) {
        currentPlayer.allGlowingPawns();
        _gameState = DuoGameStateVsComp.pickPawn;
        // notifyListeners();
        // setState(() {});
      } else {
        if (currentPlayer.pawnAtHome == 4) {
          return nextTurn();
        } else {
          currentPlayer.glowingOutsideHome();
          _gameState = DuoGameStateVsComp.pickPawn;
          // notifyListeners();
          // setState(() {});
        }
      }

      for (var i = 0; i < currentPlayer.pawns.length; i++) {
        var pawn = currentPlayer.pawns[i];
        if ((pawn.movement + diceRoll) > currentPlayer.location.length - 1) {
          currentPlayer.glowingPawn(i, false);
        }
      }

      if (currentPlayer.colr == DuoPlayerColorVsComp.red) {
        var moveableRedPawn =
            currentPlayer.pawns.where((element) => element.isGlow).toList();
        if (moveableRedPawn.length > 1) {
          var biggestMovement =
              moveableRedPawn.map((e) => e.movement).reduce(max);
          if (moveableRedPawn
              .every((element) => element.movement == biggestMovement)) {
            var random = 1 + Random().nextInt(moveableRedPawn.length - 1);
            if (moveableRedPawn[random].movement == -1) {
              var thePawn = moveableRedPawn[random];
              move(thePawn.col, thePawn.number, (thePawn.movement + 1) + 1);
              return;
            } else {
              var thePawn = moveableRedPawn[random];
              move(thePawn.col, thePawn.number,
                  (thePawn.movement + 1) + diceRoll);
              return;
            }
          }
        }
      } else if (currentPlayer.colr == DuoPlayerColorVsComp.yellow) {
        int r = Random().nextInt(3) + 1;
        Future.delayed(Duration(seconds: r)).then((value) {
          var moveableYellowPawn =
              currentPlayer.pawns.where((element) => element.isGlow).toList();
          if (moveableYellowPawn.length > 1) {
            var random = 1 + Random().nextInt(moveableYellowPawn.length - 1);
            if (moveableYellowPawn[random].movement == -1) {
              var thePawn = moveableYellowPawn[random];
              move(thePawn.col, thePawn.number, (thePawn.movement + 1) + 1);
              return;
            } else {
              var thePawn = moveableYellowPawn[random];
              move(thePawn.col, thePawn.number,
                  (thePawn.movement + 1) + diceRoll);
              return;
            }
          }
        });
      }

      //
      //
      // nextTurn for all the pawns inside the home square
      //Even if they place 6 on diceRoll
      //
      if (currentPlayer.pawns.every((element) => !element.isGlow)) {
        nextTurn();
        return;
      }
      //
      // This for the last pawn inside the initial square
      //
      //
      //
      if (currentPlayer.pawns.where((element) => element.isGlow).length == 1) {
        var index = currentPlayer.pawns.indexWhere((element) => element.isGlow);
        if (index == -1) {
          move(currentPlayer.colr, index,
              (currentPlayer.pawns[index].movement + 1) + 1);
        } else {
          move(currentPlayer.colr, index,
              (currentPlayer.pawns[index].movement + 1) + diceRoll);
        }
      }
    });
  });
}

void move(DuoPlayerColorVsComp co, int index, int movement) async {
  candy = co;
  index1 = index;
  movement1 = movement;
  if (_isTravelling) return;
  _isTravelling = true;
  _gameState = DuoGameStateVsComp.moving;

  currentPlayer.allGlowingPawns(false);

  var selectedPlayer = player(co);
  for (int i = selectedPlayer.pawns[index].movement; i < movement; i++) {
    if (_stopTravelling) break;
    if (selectedPlayer.pawns[index].movement == i) continue;
    selectedPlayer.movePawn(index, i);
    // await Audio.playMove();
    // notifyListeners();
    // setState(() {});
    if (_stopTravelling) break;
  }
  if (checkToKill(co, index, movement, selectedPlayer.location)) {
    _gameState = DuoGameStateVsComp.throwDice;
    if (currentPlayer.colr == DuoPlayerColorVsComp.yellow) {
      rollDice();
    }
    _isTravelling = false;
    // Audio.playKill();
    // notifyListeners();
    // setState(() {});
    return;
  }

  validateWin(co);

  if (diceRoll == 6) {
    _gameState = DuoGameStateVsComp.throwDice;
    if (currentPlayer.colr == DuoPlayerColorVsComp.yellow) {
      rollDice();
    }
    // notifyListeners();
    // setState(() {});
  } else {
    nextTurn();
    // notifyListeners();
    // setState(() {});
  }
  _isTravelling = false;
}

void nextTurn() async {
  await Future.delayed(const Duration(seconds: 1)).then((value) {
    // stopTimer();
    switch (_currentColor) {
      case DuoPlayerColorVsComp.red:
        six = 0;
        _playerTurn = false;
        _computerTurn = true;
        _currentColor = DuoPlayerColorVsComp.yellow;
        // notifyListeners();
        // setState(() {});
        break;
      case DuoPlayerColorVsComp.yellow:
        six = 0;
        _playerTurn = true;
        _computerTurn = false;
        _currentColor = DuoPlayerColorVsComp.red;
        // notifyListeners();
        // setState(() {});
        break;
    }

    // ignore: iterable_contains_unrelated_type
    if (won.contains(currentPlayer)) {
      _gameState = DuoGameStateVsComp.finish;
      return;
    }
  });
  _gameState = DuoGameStateVsComp.throwDice;
  if (currentPlayer.colr == DuoPlayerColorVsComp.yellow) {
    rollDice();
  }
}

bool checkToKill(
    DuoPlayerColorVsComp type, int index, int step, List<List<double>> path) {
  bool killSomeone = false;
  for (int i = 0; i < 4; i++) {
    var redElement = player(DuoPlayerColorVsComp.red).pawns[i];
    var yellowElement = player(DuoPlayerColorVsComp.yellow).pawns[i];

    if ((redElement.movement > -1 &&
            !DuoPlayerPathVsComp.safeArea.map((e) => e.toString()).contains(
                player(DuoPlayerColorVsComp.red)
                    .location[redElement.movement]
                    .toString())) &&
        type != DuoPlayerColorVsComp.red) {
      if (player(DuoPlayerColorVsComp.red)
              .location[redElement.movement]
              .toString() ==
          path[step - 1].toString()) {
        killSomeone = true;
        player(DuoPlayerColorVsComp.red).movePawn(i, -1);
        // notifyListeners();
        // setState(() {});
      }
    }
    if ((yellowElement.movement > -1 &&
            !DuoPlayerPathVsComp.safeArea.map((e) => e.toString()).contains(
                player(DuoPlayerColorVsComp.yellow)
                    .location[yellowElement.movement]
                    .toString())) &&
        type != DuoPlayerColorVsComp.yellow) {
      if (player(DuoPlayerColorVsComp.yellow)
              .location[yellowElement.movement]
              .toString() ==
          path[step - 1].toString()) {
        killSomeone = true;
        player(DuoPlayerColorVsComp.yellow).movePawn(i, -1);
        // notifyListeners();
        // setState(() {});
      }
    }
  }
  return killSomeone;
}

void validateWin(DuoPlayerColorVsComp color) {
  if (player(color)
      .pawns
      .map((e) => e.movement)
      .every((element) => element == player(color).location.length - 1)) {
    won.add(color);
    // notifyListeners();
    // setState(() {});
  }
}

// /////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//
//
// LUDO PROVIDER CLASS
//
//
//
//
// /////////////////////////////////////////////////////////////////////////////////////////////////

// ///////////////////////////////////////////////////////////////////////////////
//
//
//  LUDO MAIN PAGE
//
//
// ////////////////////////////////////////////////////////////////////////////////

class LudoMain2 extends StatefulWidget {
  const LudoMain2({super.key});

  @override
  State<LudoMain2> createState() => _LudoMain2State();
}

class _LudoMain2State extends State<LudoMain2> {
  //////////////////////////////////////////
  //
  //
  //Ending of Provider Functions
  //
  //
  // /////////////////////////////////////
  //

  //

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ///////
    //
    // Card Size
    //
    double cardSize(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
      if (width > 500) {
        return 500;
      } else if (width < 300) {
        return 300;
      } else {
        return width - 20;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Human Vs Computer"),
        backgroundColor: const Color.fromARGB(255, 6, 26, 62),
      ),
      backgroundColor: const Color.fromARGB(255, 6, 26, 62),
      body: SafeArea(
          child: Center(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                !playerTurn
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: cardSize(context) * .4 - 8,
                            height: 60,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 220, 201, 25),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      right: 10, bottom: 8),
                                  alignment: Alignment.bottomRight,
                                  child: const SizedBox(
                                      height: 45,
                                      width: 45,
                                      child:
                                          DuoPlayerDiceVsComp() //Class of Dice Widget,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: cardSize(context) * .4 - 8,
                            height: 60,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 220, 201, 25),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // ignore: avoid_unnecessary_containers
                                Container(
                                  child: const SizedBox(
                                    height: 45,
                                    width: 45, //Class of Dice Widget,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                const DuoPlayerBoardVsComp(),
                //Class of Ludo Board Widget
                playerTurn
                    ? Row(
                        children: [
                          Container(
                            width: cardSize(context) * .4 - 8,
                            height: 60,
                            margin: const EdgeInsets.only(left: 10),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 197, 80, 51),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                // playerTimer(),
                                // Container(
                                //     margin: EdgeInsets.only(right: 10),
                                //     child: CircleAvatar(
                                //         backgroundImage: AssetImage(
                                //             "images/person.png"))),

                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 10, top: 8),
                                  alignment: Alignment.topLeft,
                                  child: const SizedBox(
                                    height: 45,
                                    width: 45,
                                    child:
                                        DuoPlayerDiceVsComp(), //Class of Dice Widget,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Container(
                            width: cardSize(context) * .4 - 8,
                            margin: const EdgeInsets.only(left: 10),
                            height: 60,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 197, 80, 51),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                // Container(
                                //     margin: EdgeInsets.only(right: 10),
                                //     child: CircleAvatar(
                                //         backgroundImage: AssetImage(
                                //             "images/person.png"))),
                                // ignore: avoid_unnecessary_containers
                                Container(
                                  child: const SizedBox(
                                    height: 45,
                                    width: 45, //Class of Dice Widget,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

// /////////////////////////////////////////////////////////////////////////////////
//
//
//
// LUDO CONSTANTS
//
//
//
//
// ////////////////////////////////////////////////////////////////////////////////

enum DuoPlayerColorVsComp { red, yellow }

enum DuoGameStateVsComp { throwDice, pickPawn, moving, finish }

class DuoColorsVsComp {
  static const Color red = Colors.red;
  static const Color yellow = Color.fromARGB(255, 211, 211, 68);
}

class DuoPlayerPathVsComp {
  static double calcPawnsStep(double ludoBoardSize, double noOfBox) {
    double boxSize = (ludoBoardSize / 15);
    double pawnTravel = boxSize * noOfBox;
    return pawnTravel;
  }

  ///Safe path that is the path where the pawns can move without getting killed
  static const List<List<double>> safeArea = [
    [6, 2],
    [12, 6],
    [8, 12],
    [2, 8],
    /////////
    [8, 1],
    [13, 8],
    [6, 13],
    [1, 6],
  ];

  static const List<List<double>> redHomeLocation = [
    [1.5, 10.5],
    [1.5, 12.5],
    [3.5, 10.5],
    [3.5, 12.5],
  ];

  static const List<List<double>> yellowHomeLocation = [
    [10.5, 1.5],
    [10.5, 3.5],
    [12.5, 1.5],
    [12.5, 3.5],
  ];

  static const List<List<double>> redTravellingPath = [
    ////////RED RIGHT
    [6, 13],
    [6, 12],
    [6, 11],
    [6, 10],
    [6, 9],
    ////////RED TOP
    [5, 8],
    [4, 8],
    [3, 8],
    [2, 8],
    [1, 8],
    [0, 8],
    ////////RED TO GREEN
    [0, 7],
    ////////GREEN BOTOM
    [0, 6],
    [1, 6],
    [2, 6],
    [3, 6],
    [4, 6],
    [5, 6],
    ////////GREEN RIGHT
    [6, 5],
    [6, 4],
    [6, 3],
    [6, 2],
    [6, 1],
    [6, 0],
    ////////GREEN TO YELLOW
    [7, 0],
    ////////YELLOW LEFT
    [8, 0],
    [8, 1],
    [8, 2],
    [8, 3],
    [8, 4],
    [8, 5],
    ////////YELLOW BOTTOM
    [9, 6],
    [10, 6],
    [11, 6],
    [12, 6],
    [13, 6],
    [14, 6],
    ////////YELLOW TO BLUE
    [14, 7],
    ////////BLUE TOP
    [14, 8],
    [13, 8],
    [12, 8],
    [11, 8],
    [10, 8],
    [9, 8],
    ////////BLUE LEFT
    [8, 9],
    [8, 10],
    [8, 11],
    [8, 12],
    [8, 13],
    [8, 14],
    ////////BLUE TO RED WINNER PATH
    [7, 14],
    ////////RED WINNER PATH
    [7, 13],
    [7, 12],
    [7, 11],
    [7, 10],
    [7, 9],
    [7, 8],
  ];

  static const List<List<double>> yellowTravellingPath = [
    ////////YELLOW LEFT
    [8, 1],
    [8, 2],
    [8, 3],
    [8, 4],
    [8, 5],
    ////////YELLOW BOTTOM
    [9, 6],
    [10, 6],
    [11, 6],
    [12, 6],
    [13, 6],
    [14, 6],
    ////////YELLOW TO BLUE
    [14, 7],
    ////////BLUE TOP
    [14, 8],
    [13, 8],
    [12, 8],
    [11, 8],
    [10, 8],
    [9, 8],
    ////////BLUE LEFT
    [8, 9],
    [8, 10],
    [8, 11],
    [8, 12],
    [8, 13],
    [8, 14],
    ////////BLUE TO RED
    [7, 14],
    ////////RED RIGHT
    [6, 14],
    [6, 13],
    [6, 12],
    [6, 11],
    [6, 10],
    [6, 9],
    ////////RED TOP
    [5, 8],
    [4, 8],
    [3, 8],
    [2, 8],
    [1, 8],
    [0, 8],
    ////////RED TO GREEN
    [0, 7],
    ////////GREEN BOTOM
    [0, 6],
    [1, 6],
    [2, 6],
    [3, 6],
    [4, 6],
    [5, 6],
    ////////GREEN RIGHT
    [6, 5],
    [6, 4],
    [6, 3],
    [6, 2],
    [6, 1],
    [6, 0],
    ////////GREEN TO YELLOW WINNER PATH
    [7, 0],
    ////////YELLOW WINNER PATH
    [7, 1],
    [7, 2],
    [7, 3],
    [7, 4],
    [7, 5],
    [7, 6],
  ];
}

// ///////////////////////////////////////////////////////////////////////////////////////////
//
//
//
//
// LUDO PLAYERS CLASS
//
//
//
//
// ///////////////////////////////////////////////////////////////////////////////////////////

class DuoPlayersVsComp {
  late final DuoPlayerColorVsComp colr;
  late List<List<double>> location;

  late List<List<double>> homeLocation;

  final List<DuoPlayerPawnsVsComp> pawns = [];

  late Color color;
  //For Four Pawns
  DuoPlayersVsComp(this.colr) {
    for (int i = 0; i < 4; i++) {
      pawns.add(DuoPlayerPawnsVsComp(i, colr));
    }

    switch (colr) {
      case DuoPlayerColorVsComp.red:
        location = DuoPlayerPathVsComp.redTravellingPath;
        color = Colors.red;
        homeLocation = DuoPlayerPathVsComp.redHomeLocation;
        break;
      case DuoPlayerColorVsComp.yellow:
        location = DuoPlayerPathVsComp.yellowTravellingPath;
        color = Colors.yellow;
        homeLocation = DuoPlayerPathVsComp.yellowHomeLocation;
        break;
    }
  }

  int get pawnAtHome => pawns.where((element) => element.movement == -1).length;
  int get pawninPlay => pawns.where((element) => element.movement > -1).length;

  void movePawn(int index, int movement) async {
    pawns[index] =
        DuoPlayerPawnsVsComp(index, colr, movement: movement, isGlow: false);
  }

  void glowingPawn(int index, [bool isGlow = true]) {
    var pawn = pawns[index];
    pawns.removeAt(index);
    pawns.insert(
        index,
        DuoPlayerPawnsVsComp(
          index,
          pawn.col,
          isGlow: isGlow,
          movement: pawn.movement,
        ));
  }

  void allGlowingPawns([bool isGlow = true]) {
    for (var i = 0; i < pawns.length; i++) {
      glowingPawn(i, isGlow);
    }
  }

  void glowingOutsideHome([bool isGlow = true]) {
    for (var i = 0; i < pawns.length; i++) {
      if (pawns[i].movement != -1) glowingPawn(i, isGlow);
    }
  }

  void glowingInsideHome([bool isGlow = true]) {
    for (var i = 0; i < pawns.length; i++) {
      if (pawns[i].movement == -1) glowingPawn(i, isGlow);
    }
  }
}

// ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//
//
//
// LUDO PAWN WIDGET
//
//
//
//
// ///////////////////////////////////////////////////////////////////////////////////////////////////

class DuoPlayerPawnsVsComp extends StatefulWidget {
  final int number;
  final DuoPlayerColorVsComp col;
  final int movement;
  final bool isGlow;
  const DuoPlayerPawnsVsComp(
    this.number,
    this.col, {
    Key? key,
    this.isGlow = false,
    this.movement = -1,
  }) : super(key: key);

  @override
  State<DuoPlayerPawnsVsComp> createState() => _DuoPlayerPawnsVsCompState();
}

class _DuoPlayerPawnsVsCompState extends State<DuoPlayerPawnsVsComp> {
  @override
  Widget build(BuildContext context) {
    Color color = Colors.white;
    switch (widget.col) {
      case DuoPlayerColorVsComp.red:
        color = DuoColorsVsComp.red;
        break;
      case DuoPlayerColorVsComp.yellow:
        color = DuoColorsVsComp.yellow;
        break;
    }
    return IgnorePointer(
      ignoring: !widget.isGlow,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (widget.isGlow)
            RippleAnimation(
                color: color,
                minRadius: 25,
                repeat: true,
                ripplesCount: 2,
                child: const SizedBox.shrink()),
          GestureDetector(
            onTap: () {
              if (widget.col == DuoPlayerColorVsComp.red) {
                if (widget.movement == -1) {
                  move(widget.col, widget.number, (widget.movement + 1) + 1);
                } else {
                  move(widget.col, widget.number,
                      (widget.movement + 1) + diceRoll);
                }
                move(widget.col, widget.number, widget.movement);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2)),
              child: Container(
                decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//
//
//
// LUDO Dice WIDGET
//
//
//
//
// ///////////////////////////////////////////////////////////////////////////////////////////////////

class DuoPlayerDiceVsComp extends StatefulWidget {
  const DuoPlayerDiceVsComp({super.key});

  @override
  State<DuoPlayerDiceVsComp> createState() => _DuoPlayerDiceVsCompState();
}

class _DuoPlayerDiceVsCompState extends State<DuoPlayerDiceVsComp> {
  @override
  Widget build(BuildContext context) {
    return RippleAnimation(
      color: gamestate == DuoGameStateVsComp.throwDice
          ? currentPlayer.color
          : Colors.white.withOpacity(0),
      ripplesCount: 6,
      minRadius: 35,
      repeat: true,
      child: computerTurn
          ? Container(
              padding: const EdgeInsets.only(),
              child: isDiceRolling
                  ? Image.asset("images/dice/draw.gif", fit: BoxFit.contain)
                  : Image.asset("images/dice/$diceRoll.png",
                      fit: BoxFit.contain),
            )
          : CupertinoButton(
              onPressed: rollDice,
              padding: const EdgeInsets.only(),
              child: isDiceRolling
                  ? Image.asset("images/dice/draw.gif", fit: BoxFit.contain)
                  : Image.asset("images/dice/$diceRoll.png",
                      fit: BoxFit.contain),
            ),
    );
  }
}

// ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//
//
//
// LUDO Dice WIDGET
//
//
//
//
// ///////////////////////////////////////////////////////////////////////////////////////////////////

class DuoPlayerBoardVsComp extends StatefulWidget {
  const DuoPlayerBoardVsComp({super.key});

  @override
  State<DuoPlayerBoardVsComp> createState() => _DuoPlayerBoardVsCompState();
}

class _DuoPlayerBoardVsCompState extends State<DuoPlayerBoardVsComp> {
  int red = 0;
  int yellow = 0;
  double boardSize(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 500) {
      return 500;
    } else if (width < 300) {
      return 300;
    } else {
      return width - 20;
    }
  }

  double gridSize(BuildContext context) {
    return boardSize(context) / 15;
  }

  @override
  Widget build(BuildContext context) {
    red = sumRed;
    yellow = sumYellow;
    List<DuoPlayersVsComp> players1 = List.from(players);
    Map<String, List<DuoPlayerPawnsVsComp>> pawnRaw = {};
    Map<String, List<String>> pawnsToPrint = {};
    List<Widget> playerPawns = [];

    for (int i = 0; i < players1.length; i++) {
      var player = players1[i];
      for (int j = 0; j < player.pawns.length; j++) {
        var pawn = player.pawns[j];
        if (pawn.movement > -1) {
          String movement = player.location[pawn.movement].toString();
          if (pawnRaw[movement] == null) {
            pawnRaw[movement] = [];
            pawnsToPrint[movement] = [];
          }
          pawnRaw[movement]!.add(pawn);
          pawnsToPrint[movement]!.add(player.colr.toString());
        } else {
          if (pawnRaw["home"] == null) {
            pawnRaw["home"] = [];
            pawnsToPrint["home"] = [];
          }
          pawnRaw["home"]!.add(pawn);
          pawnsToPrint["home"]!.add(player.colr.toString());
        }
      }
    }

    for (int i = 0; i < pawnRaw.keys.length; i++) {
      String key = pawnRaw.keys.elementAt(i);
      List<DuoPlayerPawnsVsComp> pawnValue = pawnRaw[key]!;

      if (key == "home") {
        playerPawns.addAll(pawnValue.map((e) {
          var player = players.firstWhere((element) => element.colr == e.col);
          return AnimatedPositioned(
              key: ValueKey("${e.col.name}_${e.number}"),
              left: DuoPlayerPathVsComp.calcPawnsStep(
                  boardSize(context), player.homeLocation[e.number][0]),
              top: DuoPlayerPathVsComp.calcPawnsStep(
                  boardSize(context), player.homeLocation[e.number][1]),
              width: gridSize(context),
              height: gridSize(context),
              duration: const Duration(milliseconds: 200),
              child: e);
        }));
      } else {
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
            left: DuoPlayerPathVsComp.calcPawnsStep(
                boardSize(context), coordinates[0]),
            top: DuoPlayerPathVsComp.calcPawnsStep(
                boardSize(context), coordinates[1]),
            width: gridSize(context),
            height: gridSize(context),
            child: pawnValue.first,
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
                child: pawnValue[index]);
          }));
        }
      }
    }
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          width: boardSize(context),
          height: boardSize(context),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/board.png"),
              fit: BoxFit.fill,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                ...playerPawns,
                ...winners(context, won),
                turnIndicator(context, currentPlayer.colr, currentPlayer.color,
                    gamestate),
                pawnMovementText(context),
              ],
            ),
          ),
        ),
      ],
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
        child: Padding(
          padding: EdgeInsets.all(gridSize(context)),
          child: Container(
              margin: EdgeInsets.all(gridSize(context) + 12),
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: "$yellow\n",
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber)),
                ]),
              )),
        ),
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
        child: Padding(
          padding: EdgeInsets.all(gridSize(context)),
          child: Container(
              margin: EdgeInsets.all(gridSize(context) + 12),
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: const TextStyle(fontSize: 12, color: Colors.red),
                    children: [
                      // turn == DuoPlayerColor.red
                      TextSpan(
                          text: "$red\n",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ]),
              )),
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
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => const WinningScreenVsComp());
                  },
                  child: const Text("Game Over !")),
            ),
          );
        },
      );
}

// ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//
//
//
// LUDO Dice WIDGET
//
//
//
//
// ///////////////////////////////////////////////////////////////////////////////////////////////////

class WinningScreenVsComp extends StatefulWidget {
  const WinningScreenVsComp({super.key});

  @override
  State<WinningScreenVsComp> createState() => _WinningScreenVsCompState();
}

class _WinningScreenVsCompState extends State<WinningScreenVsComp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 155, 93, 93).withOpacity(1.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/images/thankyou.gif"),
              const Text("Thank you for playing 😙",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center),
              const Text("The Winners is:",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                  textAlign: TextAlign.center),
              const Divider(color: Colors.white),
              const Text("This game made by Chedo",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Go Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
