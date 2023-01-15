import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_pacman/shared/enums.dart';
import 'package:flame_pacman/shared/movement_constraints.dart';

class PacmanSprite extends SpriteComponent {
  Direction lookingAt;
  MovementConstraints movementConstraints;
  PacmanSprite(
      {this.lookingAt = Direction.right,
      this.movementConstraints = const MovementConstraints(
          bottom: 2500, right: 2500, top: 40, left: 40)})
      : super(
          size: Vector2.all(40),
          position: Vector2.all(400),
          anchor: Anchor.center,
        );
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load("pacman1.png");
  }

  move(Direction direction) {
    lootAtDirection(direction);
    if (direction == Direction.right) {
      if (x <= movementConstraints.right) {
        x++;
      }
    } else if (direction == Direction.left) {
      if (x >= movementConstraints.left) {
        x--;
      }
    } else if (direction == Direction.up) {
      if (y >= movementConstraints.top) {
        y--;
      }
    } else if (direction == Direction.down) {
      if (y <= movementConstraints.bottom) {
        y++;
      }
    }
  }

  lootAtDirection(Direction direction) {
    Map<Direction, double> angleRotation = {
      Direction.right: 0,
      Direction.left: -pi,
      Direction.up: -pi / 2,
      Direction.down: pi / 2,
    };
    angle = angleRotation[direction] ?? 0;
  }
}
