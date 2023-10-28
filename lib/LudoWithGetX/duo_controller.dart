import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ludo2/LudoWithGetX/constants.dart';
import 'package:ludo2/LudoWithGetX/duo_player.dart';
import 'package:ludo2/SoundsClass/audio.dart';

class CompVsPlayerController extends GetxController {
  //

  RxInt i = 0.obs;

  Timer? timer;
  Duration duration = new Duration();

  // Calc Lost Moves if Player Didn't play
  RxInt _calcLostMoves = 0.obs;

  int get calcLostMoves => _calcLostMoves.value;

  RxInt forResponsive = 0.obs;
  // Checking if player Turn or not
  RxBool _playerTurn = true.obs;
  bool get playerTurn => _playerTurn.value;

  //for checking number of six
  RxInt six = 0.obs;

  // Checking Computer Turn or not
  RxBool _computerTurn = false.obs;
  bool get computerTurn => _computerTurn.value;

  // For Checking movement of pawns
  RxBool _isTravelling = false.obs;

  // For stopping movement of pawns;
  RxBool _stopTravelling = false.obs;

  // For Checking the status of the game
  DuoGameStateVsComp _gameState = DuoGameStateVsComp.throwDice;

  // Check any changes in _gamestate and save them
  DuoGameStateVsComp get gameState => _gameState;

  // Which player is playing ?
  DuoPlayerColorVsComp _currentColor = DuoPlayerColorVsComp.red;

  // sum of red pawns
  int get sumRed {
    RxInt trialSum = 0.obs;
    for (int i = 0; i < player(DuoPlayerColorVsComp.red).pawns.length; i++) {
      trialSum.value += player(DuoPlayerColorVsComp.red).pawns[i].movement + 1;
    }
    return trialSum.value;
  }

// sum of Yellow pawns
  int get sumYellow {
    RxInt trialSum = 0.obs;
    for (int i = 0; i < player(DuoPlayerColorVsComp.yellow).pawns.length; i++) {
      trialSum.value +=
          player(DuoPlayerColorVsComp.yellow).pawns[i].movement + 1;
    }
    return trialSum.value;
  }

// For Checking all the changes with diceRolls
  RxInt _diceRoll = 0.obs;

// For saving and using diceRoll values in widgets
  int get diceRoll {
    if (_diceRoll.value < 1) {
      return 1;
    } else if (_diceRoll.value > 6) {
      return 6;
    } else {
      return _diceRoll.value;
    }
  }

  // To start and stop the rolling of dice
  RxBool _isDiceRolling = false.obs;
  // to store any changes in the start and stop of dice rolling
  bool get isDiceRolling => _isDiceRolling.value;

  // List of All Players to play in the Game
  final List<DuoPlayersVsComp> players = [
    DuoPlayersVsComp(DuoPlayerColorVsComp.red),
    DuoPlayersVsComp(DuoPlayerColorVsComp.yellow)
  ];

  // To check the current player
  DuoPlayersVsComp get currentPlayer =>
      players.firstWhere((element) => element.colr == _currentColor);

  // To check the number of steps a pawn has moved
  List<int> get maxPawnMovement =>
      currentPlayer.pawns.map((e) => e.movement).toList();

  //  To save the winners name
  final List<DuoPlayerColorVsComp> won = [];

  // To collect and save the info on the current player
  DuoPlayersVsComp player(DuoPlayerColorVsComp col) =>
      players.firstWhere((element) => element.colr == col);

  void rollDice() async {
    // If Computer is playing then use delay to make it more realistic
    int delay = 0;
    if (currentPlayer.colr == DuoPlayerColorVsComp.yellow) {
      int rand = Random().nextInt(2) + 1;
      delay = rand;
    } else {
      delay = 0;
    }
    // Delay to rollDice, only  for computer to make it more like human
    Future.delayed(Duration(seconds: delay)).then((value) {
      // If inside controller class and
      // _gamestate != throwDice then go out of this function
      if (_gameState != DuoGameStateVsComp.throwDice) return;

      // To show the dice rolling animation _isdiceRolling is true
      _isDiceRolling.value = true;
      Audio.rollDice();

      // All Pawns of the current player should not glow
      currentPlayer.allGlowingPawns(false);

      // For one second animation of dice rolling
      Future.delayed(const Duration(seconds: 1)).then((value) {
        // To Stop the Dice Rolling Animation
        _isDiceRolling.value = false;

        // creating variable of Random Class
        var random = Random();

        // Changing the Dice Result randomly and saving the value for future functions

        // _diceRoll.value = 6;
        if (i.value == 0) {
          // _diceRoll.value = Random().nextBool() ? 6 : random.nextInt(6) + 1;
          _diceRoll.value = random.nextInt(6) + 1;
          i.value++;
        } else {
          i.value++;
        }

        // If Player gets a six then
        // all pawns glow
        if (diceRoll == 6) {
          currentPlayer.allGlowingPawns();
          _gameState = DuoGameStateVsComp.pickPawn;
        } else {
          // if (currentPlayer.pawnAtHome == 4) {
          //   return nextTurn();
          // } else {
          currentPlayer.allGlowingPawns();
          _gameState = DuoGameStateVsComp.pickPawn;
          // }
        }

        // If pawn can has spaces to move then make that pawn "glow"
        for (int i = 0; i < currentPlayer.pawns.length; i++) {
          var pawn = currentPlayer.pawns[i];

          if ((pawn.movement + diceRoll) > currentPlayer.location.length - 1) {
            currentPlayer.glowingPawn(i, false);
          }
        }

        // If Player is Red then :
        // Check if only one pawn can move
        // if it can then move it automatically
        if (currentPlayer.colr == DuoPlayerColorVsComp.red) {
          // Check which pawns can move and store it in moveeableRedPawn
          var moveableRedPawn =
              currentPlayer.pawns.where((element) => element.isGlow).toList();
          // If the moveable pawns are more than one than :
          if (moveableRedPawn.length > 1) {
            // Get the last pawn which is farthest away
            var biggestMovement =
                moveableRedPawn.map((e) => e.movement).reduce(max);
            // If all the pawns are located together then :
            if (moveableRedPawn
                .every((element) => element.movement == biggestMovement)) {
              //Using random to Choose a random pawn
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
        }
        // Move Pawns Automatically and randomly if Player == yellow
        else if (currentPlayer.colr == DuoPlayerColorVsComp.yellow) {
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
        // If no pawns glow then nextTurn
        if (currentPlayer.pawns.every((element) => !element.isGlow)) {
          nextTurn();
          return;
        }
        // If any 1 pawn is GLowing then :
        if (currentPlayer.pawns.where((element) => element.isGlow).length ==
            1) {
          var index =
              currentPlayer.pawns.indexWhere((element) => element.isGlow);
          // if (index == -1) {
          //   move(currentPlayer.colr, index,
          //       (currentPlayer.pawns[index].movement + 1) + 1);
          // } else {
          move(currentPlayer.colr, index,
              (currentPlayer.pawns[index].movement + 1) + diceRoll);
          // }
        }
        //
        // End of Future delayed for Dice Animation move
      });
      //
      // End of Future delayed for computer move
    });
    //
    // End of Roll Dice Function
  }

  void move(DuoPlayerColorVsComp co, int index, int movement) async {
    i.value = 0;
    forResponsive.value++;
    // If _isTravelling is True then get out of this method
    if (_isTravelling.value) return;
    // Travelling is true
    _isTravelling.value = true;
    // GameState = Pawn is moving
    _gameState = DuoGameStateVsComp.moving;

    // Stop Glowing all the pawns
    currentPlayer.allGlowingPawns(false);

    // selectedPlayer  = current PLayer(co)
    var selectedPlayer = player(co);

    // if selected player pawns are at less than the movement
    for (int i = selectedPlayer.pawns[index].movement; i < movement; i++) {
      forResponsive.value++;
      if (_stopTravelling.value) break;
      forResponsive.value++;
      if (selectedPlayer.pawns[index].movement == i) continue;
      selectedPlayer.movePawn(index, i);
      await Audio.playMove();
      forResponsive.value++;
      if (_stopTravelling.value) break;
    }
    if (checkToKill(co, index, movement, selectedPlayer.location)) {
      forResponsive.value++;
      _gameState = DuoGameStateVsComp.throwDice;
      if (currentPlayer.colr == DuoPlayerColorVsComp.yellow) {
        rollDice();
      }
      _isTravelling.value = false;
      forResponsive.value++;
      Audio.playKill();
      return;
    }
    if (pawnWon()) {
      forResponsive.value++;
      _gameState = DuoGameStateVsComp.throwDice;
      if (currentPlayer.colr == DuoPlayerColorVsComp.yellow) {
        rollDice();
      }
      _isTravelling.value = false;
      forResponsive.value++;
      return;
    }

    validateWin(co);

    if (diceRoll == 6) {
      reset();
      _gameState = DuoGameStateVsComp.throwDice;
      if (currentPlayer.colr == DuoPlayerColorVsComp.yellow) {
        rollDice();
      }
    } else {
      reset();
      nextTurn();
    }
    _isTravelling.value = false;
  }

  void nextTurn() async {
    await Future.delayed(Duration(seconds: 1)).then((value) {
      // stopTimer();
      switch (_currentColor) {
        case DuoPlayerColorVsComp.red:
          six.value = 0;
          _playerTurn.value = false;
          _computerTurn.value = true;
          _currentColor = DuoPlayerColorVsComp.yellow;
          break;
        case DuoPlayerColorVsComp.yellow:
          six.value = 0;
          _playerTurn.value = true;
          _computerTurn.value = false;
          _currentColor = DuoPlayerColorVsComp.red;
          break;
      }

      if (won.contains(currentPlayer.colr)) {
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
    RxBool killSomeone = false.obs;
    for (int i = 0; i < 4; i++) {
      var redElement = player(DuoPlayerColorVsComp.red).pawns[i];
      var yellowElement = player(DuoPlayerColorVsComp.yellow).pawns[i];

      if ((redElement.movement > 0 &&
              !DuoPlayerPathVsComp.safeArea.map((e) => e.toString()).contains(
                  player(DuoPlayerColorVsComp.red)
                      .location[redElement.movement]
                      .toString())) &&
          type != DuoPlayerColorVsComp.red) {
        if (player(DuoPlayerColorVsComp.red)
                .location[redElement.movement]
                .toString() ==
            path[step - 1].toString()) {
          killSomeone.value = true;
          player(DuoPlayerColorVsComp.red).movePawn(i, 0);
        }
      }
      if ((yellowElement.movement > 0 &&
              !DuoPlayerPathVsComp.safeArea.map((e) => e.toString()).contains(
                  player(DuoPlayerColorVsComp.yellow)
                      .location[yellowElement.movement]
                      .toString())) &&
          type != DuoPlayerColorVsComp.yellow) {
        if (player(DuoPlayerColorVsComp.yellow)
                .location[yellowElement.movement]
                .toString() ==
            path[step - 1].toString()) {
          killSomeone.value = true;
          player(DuoPlayerColorVsComp.yellow).movePawn(i, 0);
        }
      }
    }
    return killSomeone.value;
  }

  //
  //To check if pawn have reached winning square
  //
  bool pawnWon() {
    RxBool wonPawn = false.obs;
    for (int i = 0; i < 4; i++) {
      var redElement = player(DuoPlayerColorVsComp.red).pawns[i];
      var yellowElement = player(DuoPlayerColorVsComp.yellow).pawns[i];

      if (redElement.movement == 56 || yellowElement.movement == 56) {
        wonPawn.value = true;
      }
    }
    return wonPawn.value;
  }

  void validateWin(DuoPlayerColorVsComp color) {
    forResponsive.value++;
    if (player(color)
        .pawns
        .map((e) => e.movement)
        .every((element) => element == player(color).location.length - 1)) {
      won.add(color);
    } // Check for missed chances according to the timer
    else if (calcLostMoves >= 3 && color == DuoPlayerColorVsComp.yellow) {
      print("Yellow Won.................................Yellow Won");
      won.add(DuoPlayerColorVsComp.yellow);
    } else if (calcLostMoves > 3 && color == DuoPlayerColorVsComp.yellow) {
      won.add(DuoPlayerColorVsComp.red);
    }
    if (won.length == 1) {
      _gameState = DuoGameStateVsComp.finish;
    }
    //
    //End of Class
  }

  //
  //
  // Timer
  //
  //

  // Time

  startTimer({bool resets = true}) async {
    if (resets) {
      reset();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
    forResponsive.value++;
  }

  void reset() {
    duration = Duration();
    forResponsive.value++;
  }

  void addTime() {
    final addSeconds = 1;

    final seconds = duration.inSeconds + addSeconds;

    duration = Duration(seconds: seconds);

    forResponsive.value++;
  }

  void stopTimer({bool resets = true}) {
    forResponsive.value++;
    if (resets) {
      reset();
    }
    // setState(() {
    timer?.cancel();
    // });
  }

  Widget playerTimer() {
    forResponsive.value++;
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String seconds = twoDigits(duration.inSeconds.remainder(16));
    print("Timer : ...................................${seconds}");
    if (seconds == "15") {
      _calcLostMoves.value++;
      currentPlayer.allGlowingPawns(false);
      // notifyListeners();
      // Checking for player Lost Chances
      reset();
      nextTurn();

      print("Calc Lost Moves : ....................${_calcLostMoves.value}");

      print("Timer is up");
    }
    return Text(
      "${seconds}",
      style: TextStyle(fontSize: 12, color: Colors.white),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    stopTimer();
    debugPrint("Checking if I am inside dispose method");
    Audio.audioPlayer.dispose();
    // onClose();
    _isTravelling.value = false;
    _stopTravelling.value = true;
    _isDiceRolling.value = false;
    super.dispose();
  }
}
