import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_pacman/game/components/walls/wall_component.dart';
import 'package:flame_pacman/game/pacman_game.dart';
import 'package:flame_pacman/shared/enums.dart';
import 'package:flame_pacman/shared/movement_constraints.dart';
import 'package:flame_pacman/shared/sprites.dart';
import 'package:flutter/material.dart';

class PacmanComponent extends SpriteComponent
    with CollisionCallbacks, HasGameRef<PacmanGame> {
  Direction lookingAt;
  double spriteSize = 40;
  int _currentSprite = 0;
  List<Sprite> sprites = [];
  bool collisionWithWall = false;
  late ShapeHitbox hitbox;
  MovementConstraints movementConstraints =
      const MovementConstraints(bottom: 2500, right: 2500, top: 40, left: 40);
  PacmanComponent(
      {this.lookingAt = Direction.right,
      this.spriteSize = 40,
      super.position,
      this.movementConstraints = const MovementConstraints(
          bottom: 2500, right: 2500, top: 40, left: 40)})
      : super(
          size: Vector2.all(spriteSize),
          anchor: Anchor.center,
        );
  @override
  Future<void> onLoad() async {
    sprites = [
      await Sprite.load(Sprites.pacman1),
      await Sprite.load(Sprites.pacman2),
      await Sprite.load(Sprites.pacman3),
    ];
    sprite = sprites[_currentSprite];
    size = Vector2.all(spriteSize);
    movementConstraints = movementConstraints.copyWith(
        right: gameRef.size.x - spriteOffset,
        left: spriteOffset,
        top: spriteOffset,
        bottom: gameRef.size.y - spriteOffset);
    final defaultPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke;

    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..renderShape = true;
    add(hitbox);
  }

  double get spriteOffset => spriteSize;

  move(Direction direction) {
    lootAtDirection(direction);
    updateSprite();
    if (collisionWithWall) {
      return;
    }
    if (direction == Direction.right) {
      if ((x + spriteOffset) <= movementConstraints.right) {
        final components = game.componentsAtPoint(Vector2(x + spriteOffset, y));
        if (components.any((e) => e is WallComponent)) {
          return;
        }
        x += spriteOffset;
      }
    } else if (direction == Direction.left) {
      if ((x - spriteOffset) >= movementConstraints.left) {
        final components = game.componentsAtPoint(Vector2(x - spriteOffset, y));
        if (components.any((e) => e is WallComponent)) {
          return;
        }
        x -= spriteOffset;
      }
    } else if (direction == Direction.up) {
      if ((y - spriteOffset) >= movementConstraints.top) {
        final components = game.componentsAtPoint(Vector2(x, y - spriteOffset));
        if (components.any((e) => e is WallComponent)) {
          return;
        }
        y -= spriteOffset;
      }
    } else if (direction == Direction.down) {
      if ((y + spriteOffset) <= movementConstraints.bottom) {
        final components = game.componentsAtPoint(Vector2(x, y + spriteOffset));
        if (components.any((e) => e is WallComponent)) {
          return;
        }
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

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    debugPrint("${intersectionPoints} $other");

    if (other is WallComponent) {
      collisionWithWall = true;
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is WallComponent) {
      collisionWithWall = false;
    }
    super.onCollisionEnd(other);
  }
}
