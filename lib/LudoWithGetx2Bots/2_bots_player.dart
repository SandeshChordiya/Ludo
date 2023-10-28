import 'package:flutter/material.dart';
import 'package:ludo2/LudoWithGetx2Bots/2_bots_constants.dart';
import 'package:ludo2/LudoWithGetx2Bots/ludo_with_getx_2_bots_main_screen.dart';

class LudoWith2BotsPlayers {
  final LudoWith2BotsPlayer colr;

  late List<List<double>> location;

  final List<LudoWith2BotsPawn> pawns = [];

  late Color color;
  //For Four Pawns
  LudoWith2BotsPlayers(this.colr) {
    for (int i = 0; i < 4; i++) {
      pawns.add(LudoWith2BotsPawn(i, colr));
    }

    switch (colr) {
      case LudoWith2BotsPlayer.red:
        location = LudoWith2BotsPath.redPath;
        color = Colors.red;
        break;
      case LudoWith2BotsPlayer.yellow:
        location = LudoWith2BotsPath.yellowPath;
        color = Colors.yellow;
        break;
      case LudoWith2BotsPlayer.green:
        location = LudoWith2BotsPath.greenPath;
        color = Colors.green;
        break;
    }
  }

  int get pawninPlay => pawns.where((element) => element.movement > 0).length;

  void movePawn(int index, int movement) async {
    pawns[index] =
        LudoWith2BotsPawn(index, colr, movement: movement, isGlow: false);
  }

  void glowingPawn(int index, [bool isGlow = true]) {
    var pawn = pawns[index];
    pawns.removeAt(index);
    pawns.insert(
        index,
        LudoWith2BotsPawn(
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
}
