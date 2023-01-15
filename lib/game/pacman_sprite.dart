import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_pacman/game/pacman_game.dart';
import 'package:flame_pacman/shared/enums.dart';
import 'package:flame_pacman/shared/movement_constraints.dart';

class PacmanSprite extends SpriteComponent with HasGameRef<PacmanGame> {
  Direction lookingAt;
  double spriteSize = 40;
  int _currentSprite = 0;
  List<Sprite> sprites = [];
  MovementConstraints movementConstraints =
      const MovementConstraints(bottom: 2500, right: 2500, top: 40, left: 40);
  PacmanSprite(
      {this.lookingAt = Direction.right,
      this.spriteSize = 40,
      this.movementConstraints = const MovementConstraints(
          bottom: 2500, right: 2500, top: 40, left: 40)})
      : super(
          size: Vector2.all(40),
          position: Vector2.all(400),
          anchor: Anchor.center,
        );
  @override
  Future<void> onLoad() async {
    sprites = [
      await Sprite.load("pacman1.png"),
      await Sprite.load("pacman2.png"),
      await Sprite.load("pacman3.png"),
    ];
    sprite = sprites[_currentSprite];
    size = Vector2.all(spriteSize);
    movementConstraints = movementConstraints.copyWith(
        right: gameRef.size.x - spriteOffset,
        left: spriteOffset,
        top: spriteOffset,
        bottom: gameRef.size.y - spriteOffset);
  }

  double get spriteOffset => spriteSize / 2;

  move(Direction direction) {
    lootAtDirection(direction);
    updateSprite();
    if (direction == Direction.right) {
      if ((x + spriteOffset) <= movementConstraints.right) {
        x += spriteOffset;
      }
    } else if (direction == Direction.left) {
      if ((x - spriteOffset) >= movementConstraints.left) {
        x -= spriteOffset;
      }
    } else if (direction == Direction.up) {
      if ((y - spriteOffset) >= movementConstraints.top) {
        y -= spriteOffset;
      }
    } else if (direction == Direction.down) {
      if ((y + spriteOffset) <= movementConstraints.bottom) {
        y += spriteOffset;
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
    lookingAt = direction;
  }

  updateSprite() {
    _currentSprite++;
    if (_currentSprite > 2) {
      _currentSprite = 0;
    }
    sprite = sprites[_currentSprite];
  }
}
