import 'package:flutter/material.dart';
import 'package:ludo2/LudoWithGetx3Bots/3_bots_constants.dart';
import 'package:ludo2/LudoWithGetx3Bots/ludo_with_3_bots_main_screen.dart';

class LudoWith3BotsPlayers {
  final LudoWith3BotsPlayer colr;

  late List<List<double>> location;

  final List<LudoWith3BotsPawn> pawns = [];

  late Color color;
  //For Four Pawns
  LudoWith3BotsPlayers(this.colr) {
    for (int i = 0; i < 4; i++) {
      pawns.add(LudoWith3BotsPawn(i, colr));
    }

    switch (colr) {
      case LudoWith3BotsPlayer.red:
        location = LudoWith3BotsPath.redPath;
        color = Colors.red;
        break;
      case LudoWith3BotsPlayer.blue:
        location = LudoWith3BotsPath.bluePath;
        color = Colors.blue;
        break;
      case LudoWith3BotsPlayer.yellow:
        location = LudoWith3BotsPath.yellowPath;
        color = Colors.yellow;
        break;
      case LudoWith3BotsPlayer.green:
        location = LudoWith3BotsPath.greenPath;
        color = Colors.green;
        break;
    }
  }

  int get pawninPlay => pawns.where((element) => element.movement > 0).length;

  void movePawn(int index, int movement) async {
    pawns[index] =
        LudoWith3BotsPawn(index, colr, movement: movement, isGlow: false);
  }

  void glowingPawn(int index, [bool isGlow = true]) {
    var pawn = pawns[index];
    pawns.removeAt(index);
    pawns.insert(
        index,
        LudoWith3BotsPawn(
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
