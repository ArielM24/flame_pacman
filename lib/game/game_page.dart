import 'package:flame/game.dart';
import 'package:flame_pacman/game/pacman_game.dart';
import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GameWidget.controlled(gameFactory: PacmanGame.new);
  }
}
