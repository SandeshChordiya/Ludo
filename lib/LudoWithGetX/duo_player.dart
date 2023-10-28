import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ludo2/LudoWithGetX/constants.dart';
import 'package:ludo2/LudoWithGetX/ludo_main_using_getx.dart';

class DuoPlayersVsComp extends GetxController {
  final DuoPlayerColorVsComp colr;

  late List<List<double>> location;

  late List<List<double>> homeLocation;

  final List<CompVsPlayerPawn> pawns = [];

  late Color color;
  //For Four Pawns
  DuoPlayersVsComp(this.colr) {
    for (int i = 0; i < 4; i++) {
      pawns.add(CompVsPlayerPawn(i, colr));
    }

    switch (colr) {
      case DuoPlayerColorVsComp.red:
        location = DuoPlayerPathVsComp.redTravellingPath;
        color = Colors.red;
        // homeLocation = DuoPlayerPathVsComp.redHomeLocation;
        break;
      case DuoPlayerColorVsComp.yellow:
        location = DuoPlayerPathVsComp.yellowTravellingPath;
        color = Colors.yellow;
        // homeLocation = DuoPlayerPathVsComp.yellowHomeLocation;
        break;
    }
  }

  // int get pawnAtHome => pawns.where((element) => element.movement == -1).length;
  int get pawninPlay => pawns.where((element) => element.movement > 0).length;
  // int get pawninPlay => pawns.where((element) => element.movement > 0).length;

  void movePawn(int index, int movement) async {
    pawns[index] =
        CompVsPlayerPawn(index, colr, movement: movement, isGlow: false);
  }

  void glowingPawn(int index, [bool isGlow = true]) {
    var pawn = pawns[index];
    pawns.removeAt(index);
    pawns.insert(
        index,
        CompVsPlayerPawn(
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

  // void glowingOutsideHome([bool isGlow = true]) {
  //   for (var i = 0; i < pawns.length; i++) {
  //     if (pawns[i].movement != -1) glowingPawn(i, isGlow);
  //   }
  // }

  // void glowingInsideHome([bool isGlow = true]) {
  //   for (var i = 0; i < pawns.length; i++) {
  //     if (pawns[i].movement == -1) glowingPawn(i, isGlow);
  //   }
  // }
}
