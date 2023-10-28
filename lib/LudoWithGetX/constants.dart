import 'package:flutter/material.dart';

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

  // static const List<List<double>> redHomeLocation = [
  //   [1.5, 10.5],
  //   [1.5, 12.5],
  //   [3.5, 10.5],
  //   [3.5, 12.5],
  // ];

  // static const List<List<double>> yellowHomeLocation = [
  //   [10.5, 1.5],
  //   [10.5, 3.5],
  //   [12.5, 1.5],
  //   [12.5, 3.5],
  // ];

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
