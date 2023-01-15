import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_pacman/game/pacman_sprite.dart';
import 'package:flame_pacman/shared/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class PacmanGame extends FlameGame with KeyboardEvents {
  late final PacmanSprite pacmanSprite;
  @override
  Future<void> onLoad() async {
    pacmanSprite = PacmanSprite();
    await add(pacmanSprite);
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
