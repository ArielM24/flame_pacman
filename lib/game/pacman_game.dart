import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_pacman/game/components/pacman_component.dart';
import 'package:flame_pacman/game/components/walls/wall_cross.dart';
import 'package:flame_pacman/game/components/walls/wall_edge_line.dart';
import 'package:flame_pacman/shared/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'components/walls/wall_component.dart';

class PacmanGame extends FlameGame with KeyboardEvents, HasCollisionDetection {
  late final PacmanComponent pacmanSprite;
  late final WallComponent wall1, wall2, wall3, wall4, wall5, wall6, wall7;

  @override
  Future<void> onLoad() async {
    pacmanSprite = PacmanComponent(position: Vector2(300, 400));
    await add(pacmanSprite);

    final wallEdgeLine = WallEdgeLine(position: Vector2(720, 60));
    add(wallEdgeLine);

    final wallCross = WallCross(position: Vector2(740, 240));
    add(wallCross);
    final wallCross2 = WallCross(position: Vector2(620, 280));
    wallCross2.angle = -pi / 2;
    add(wallCross2);
    final wallCross3 = WallCross(position: Vector2(860, 280));
    wallCross3.angle = pi / 2;
    add(wallCross3);
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
