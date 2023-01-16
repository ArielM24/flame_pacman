import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_pacman/game/components/pacman_component.dart';
import 'package:flame_pacman/shared/constants.dart';
import 'package:flame_pacman/shared/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'components/walls/game_walls.dart';

class PacmanGame extends FlameGame with KeyboardEvents, HasCollisionDetection {
  late final PacmanComponent pacmanSprite;

  @override
  Future<void> onLoad() async {
    pacmanSprite = PacmanComponent(
        position:
            Vector2(Constants.spritesOffsetN(3), Constants.spritesSize * 3));
    await add(pacmanSprite);

    final gameWalls = GameWalls();
    add(gameWalls);
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    final isRight = keysPressed.contains(LogicalKeyboardKey.arrowRight);
    final isLeft = keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isUp = keysPressed.contains(LogicalKeyboardKey.arrowUp);
    final isDown = keysPressed.contains(LogicalKeyboardKey.arrowDown);

    if (isKeyDown) {
      if (isRight) {
        pacmanSprite.move(Direction.right);
      } else if (isLeft) {
        pacmanSprite.move(Direction.left);
      } else if (isUp) {
        pacmanSprite.move(Direction.up);
      } else if (isDown) {
        pacmanSprite.move(Direction.down);
      } else {
        return KeyEventResult.ignored;
      }
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  moveRight() {
    pacmanSprite.x++;
    pacmanSprite.angle += pi;
  }

  moveLeft() {
    pacmanSprite.x--;
  }

  moveUp() {
    pacmanSprite.y--;
  }

  moveDown() {
    pacmanSprite.y++;
  }
}
