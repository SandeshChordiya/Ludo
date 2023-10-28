import 'dart:math';

import 'package:flutter/material.dart';

////////////////////////////////////////////////
//
// Players Colors
//
//
//
enum DuoPlayerColorVsComp { red, yellow }

////////////////////////////////////////////////
//
// Players Game State
//
//
//
enum DuoGameStateVsComp { throwDice, pickPawn, moving, finish }

////////////////////////////////////////////////
//
// Applying const Colors to both players
//
//
//
class DuoColorsVsComp {
  static const Color red = Colors.red;
  static const Color yellow = Color.fromARGB(255, 211, 211, 68);
}

////////////////////////////////////////////////
//
// Players paths and Calculate their movement using calcPawnStep
// These paths can't be changed for the entire game
//
//
//
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

// ///////////////////////////////////////////////////////////////////////
//
// Red Pawns Class for Working
//
//
// class PlayerVsCompRedPawns {
//   final int number;
//   final Color col;
//   final int movement;
//   final bool isGlow;
//   const PlayerVsCompRedPawns(
//     this.number, {
//     Key? key,
//     this.isGlow = false,
//     this.movement = -1,
//     this.col = Colors.red,
//   });
// }

// ///////////////////////////////////////////////////////////////////////
//
// Red Pawns Class for Working
//
//
//
// class PlayerVsCompYellowPawns {
//   final int number;
//   final int movement;
//   final bool isGlow;
//   const PlayerVsCompYellowPawns(
//     this.number, {
//     Key? key,
//     this.isGlow = false,
//     this.movement = -1,
//     final Color col = Colors.yellow,
//   });
// }

// ///////////////////////////////////////////////////////////////////////
//
// Pawns Class for Working
//
//
//
class PlayerVsCompPawns {
  final int number;
  final int movement;
  final bool isGlow;
  final DuoPlayerColorVsComp col;
  const PlayerVsCompPawns(this.number, this.col,
      {Key? key, this.isGlow = false, this.movement = -1})
      : super();
}

// ///////////////////////////////////////////////////////////////////////
//
// Player Class
//
//
//
class DuoPlayersVsComp {
  late final DuoPlayerColorVsComp colr;

  late List<List<double>> location;

  late List<List<double>> homeLocation;

  final List<PlayerVsCompPawns> pawns = [];

  late Color color;
  //For Four Pawns
  DuoPlayersVsComp(this.colr) {
    for (int i = 0; i < 4; i++) {
      pawns.add(PlayerVsCompPawns(i, colr));
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
        PlayerVsCompPawns(index, colr, movement: movement, isGlow: false);
  }

  void glowingPawn(int index, [bool isGlow = true]) {
    var pawn = pawns[index];
    pawns.removeAt(index);
    pawns.insert(
        index,
        PlayerVsCompPawns(
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

// ///////////////////////////////////////////////////////////////////////
//
//
//
// Main Widget Class
//
//
//
class LudoMain extends StatefulWidget {
  const LudoMain({super.key});

  @override
  State<LudoMain> createState() => _LudoMainState();
}

class _LudoMainState extends State<LudoMain> {
  int x = 0;
  ////////////////////////////////////////////////
  //
  // Calculating board Size according to the device
  //
  //
  //
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

  ////////////////////////////////////////////////
  //
  // Calculating board Size according to the device
  //
  //
  double pawnSize(BuildContext context) {
    double size = boardSize(context) / 15;
    return size;
  }

  // ///////////////////////////////////////////////
  //
  //
  // Main Screen For Ludo Game
  // which means this is the * Main Widget * of the Game
  //
  //
  //
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Ludo Human Vs Computer using setState"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //////////////////////////////////////////////
          //
          // Ludo Board Image
          //
          //
          board(context),

          ///////////////////////////////////////////////////
          //
          // Ludo Dice
          //
          //
          SizedBox(
            height: 65,
            width: 65,
            child: dice(context),
          ),

          ///////////////////////////////////////////////////
          //
          // Ludo Red Pawns
          //
          //
          // SizedBox(
          //   height: pawnSize(context),
          //   width: pawnSize(context),
          //   child: redPawns(context),
          // ),

          ///////////////////////////////////////////////////
          //
          // Ludo Yellow Pawns
          //
          //
          // SizedBox(
          //   height: pawnSize(context),
          //   width: pawnSize(context),
          //   child: yellowPawns(context),
          // ),

          ///////////////////////////////////////////////////
          //
          // Ludo  Pawns
          //
          //
          SizedBox(
            height: pawnSize(context),
            width: pawnSize(context),
            child: pawns(context),
          ),
        ],
      ),
    ));
  }

  Widget board(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: boardSize(context),
      width: boardSize(context),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/board.png"),
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }

  // ///////////////////////////////////////////////////////
  //
  //
  // Dice Widget for Dice
  //
  //
  Widget dice(BuildContext context) {
    return Image.asset(
      "images/dice/1.png",
      fit: BoxFit.contain,
    );
  }

  // ///////////////////////////////////////////////////////
  //
  //
  // Red Pawn Widget for Pawns
  //
  //
  // Widget redPawns(BuildContext context) {
  //   // PlayerVsCompRedPawns? pawnsRed;
  //   // PlayerVsCompYellowPawns? pawnsYellow;
  //   // Color color = Colors.white;
  //   Color color = Colors.red;
  //   // switch (pawns!.col) {
  //   //   case DuoPlayerColorVsComp.red:
  //   //     color = DuoColorsVsComp.red;
  //   //     break;
  //   //   case DuoPlayerColorVsComp.yellow:
  //   //     color = DuoColorsVsComp.yellow;
  //   //     break;
  //   // }
  //   return Container(
  //     decoration: BoxDecoration(
  //         shape: BoxShape.circle, border: Border.all(color: color, width: 2)),
  //     child: Container(
  //       decoration: BoxDecoration(
  //           color: color,
  //           shape: BoxShape.circle,
  //           border: Border.all(color: Colors.white, width: 3)),
  //     ),
  //   );
  // }

  // ///////////////////////////////////////////////////////
  //
  //
  // Yellow Pawn Widget for Pawns
  //
  //
  // Widget yellowPawns(BuildContext context) {
  //   // PlayerVsCompRedPawns? pawnsRed;
  //   // PlayerVsCompYellowPawns? pawnsYellow;
  //   // Color color = Colors.white;
  //   Color color = const Color.fromARGB(255, 210, 194, 55);
  //   // switch (pawns!.col) {
  //   //   case DuoPlayerColorVsComp.red:
  //   //     color = DuoColorsVsComp.red;
  //   //     break;
  //   //   case DuoPlayerColorVsComp.yellow:
  //   //     color = DuoColorsVsComp.yellow;
  //   //     break;
  //   // }
  //   return Container(
  //     decoration: BoxDecoration(
  //         shape: BoxShape.circle, border: Border.all(color: color, width: 2)),
  //     child: Container(
  //       decoration: BoxDecoration(
  //           color: color,
  //           shape: BoxShape.circle,
  //           border: Border.all(color: Colors.white, width: 3)),
  //     ),
  //   );
  // }

  Widget pawns(BuildContext context) {
    // PlayerVsCompRedPawns? pawnsRed;
    // PlayerVsCompYellowPawns? pawnsYellow;
    // Color color = Colors.white;
    Color color = Colors.red;
    // switch (pawns!.col) {
    //   case DuoPlayerColorVsComp.red:
    //     color = DuoColorsVsComp.red;
    //     break;
    //   case DuoPlayerColorVsComp.yellow:
    //     color = DuoColorsVsComp.yellow;
    //     break;
    // }

    return GestureDetector(
      onTap: () {
        x++;
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle, border: Border.all(color: color, width: 2)),
        child: Container(
          decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3)),
        ),
      ),
    );
  }
}
