import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_pacman/game/components/walls/wall_component.dart';
import 'package:flame_pacman/shared/constants.dart';
import 'package:flame_pacman/shared/trajectory/position_helper.dart';
import 'package:flame_pacman/shared/enums.dart';
import 'package:flame_pacman/shared/movement_constraints.dart';
import 'package:flame_pacman/shared/sprites.dart';
import 'package:flame_pacman/shared/trajectory/trajectory_helper.dart';
import 'package:flutter/material.dart';

class PacmanComponent extends SpriteComponent
    with
        CollisionCallbacks,
        HasGameRef<FlameGame>,
        PositionHelper,
        TrajectoryHelper {
  Direction lookingAt;
  double velocity;

  int _currentSprite = 0;
  List<Sprite> sprites = [];
  bool collisionWithWall = false;
  late ShapeHitbox hitbox;
  late MovementConstraints movementConstraints = MovementConstraints(
      bottom: game.size.y,
      right: game.size.x,
      top: Constants.spritesSize,
      left: Constants.spritesSize);

  PacmanComponent(
      {this.lookingAt = Direction.right,
      super.position,
      this.velocity = 1.5,
      this.movementConstraints = const MovementConstraints(
          bottom: 2500,
          right: 2500,
          top: Constants.spritesSize,
          left: Constants.spritesSize)})
      : super(
          size: Vector2.all(Constants.spritesSize),
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
    size = Vector2.all(Constants.spritesSize * 0.8);
    movementConstraints = movementConstraints.copyWith(
        right: gameRef.size.x - spriteVelocity,
        left: spriteVelocity,
        top: spriteVelocity,
        bottom: gameRef.size.y - spriteVelocity);
    debugMode = true;
    add(RectangleHitbox(isSolid: true));
    super.onLoad();
  }

  double get spriteVelocity => size.x * velocity;

  bool isInBoundsToMove(Direction direction) {
    switch (direction) {
      case Direction.right:
        return (x + spriteVelocity) <= movementConstraints.right;
      case Direction.left:
        return (x - spriteVelocity) >= movementConstraints.left;
      case Direction.up:
        return (y - spriteVelocity) >= movementConstraints.top;
      case Direction.down:
        return (y + spriteVelocity) <= movementConstraints.bottom;
      default:
    }
    return true;
  }

  move(Direction direction) {
    lootAtDirection(direction);
    updateSprite();
    if (!isInBoundsToMove(direction)) {
      return;
    }
    final moveToPos = edgeSafePosition(
        spriteVelocity, () => WallComponent(type: WallType.cross1), direction);
    position = moveToPos;

    // if (direction == Direction.right) {
    //   if ((x + spriteVelocity) <= movementConstraints.right) {
    //     final moveToX = edgeSafePosition(
    //         spriteVelocity, () => WallComponent(type: WallType.cross1));
    //     x = moveToX;
    //   }
    // } else if (direction == Direction.left) {
    //   if ((x - spriteVelocity) >= movementConstraints.left) {
    //     final moveToX = leftEdgeSafePosition(
    //         spriteVelocity, () => WallComponent(type: WallType.cross1));
    //     x = moveToX;
    //   }
    // } else if (direction == Direction.up) {
    //   if ((y - spriteVelocity) >= movementConstraints.top) {
    //     final moveToY = topEdgeSafePosition(
    //         spriteVelocity, () => WallComponent(type: WallType.cross1));
    //     y = moveToY;
    //   }
    // } else if (direction == Direction.down) {
    //   if ((y + spriteVelocity) <= movementConstraints.bottom) {
    //     final moveToY = bottomEdgeSafePosition(
    //         spriteVelocity, () => WallComponent(type: WallType.cross1));
    //     y = moveToY;
    //   }
    // }
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
    // if (other is WallComponent) {
    //   collisionWithWall = true;
    //   if (lookingAt == Direction.right) {
    //     x -= spriteOffset * 2;
    //   } else if (lookingAt == Direction.left) {
    //     x += spriteOffset * 2;
    //   }
    //   if (lookingAt == Direction.down) {
    //     y -= spriteOffset * 2;
    //   }
    //   if (lookingAt == Direction.up) {
    //     y += spriteOffset * 2;
    //   }
    // }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is WallComponent) {
      collisionWithWall = false;
      debugPrint("collision ends");
    }
    super.onCollisionEnd(other);
  }

  @override
  EdgeCollisionType get edgeCollisionType => EdgeCollisionType.cornersOnly;

  @override
  double get stepCheckDistance => Constants.spritesSize;
}
