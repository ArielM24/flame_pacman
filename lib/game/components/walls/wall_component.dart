import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_pacman/game/components/pacman_component.dart';
import 'package:flame_pacman/shared/enums.dart';
import 'package:flame_pacman/shared/sprites.dart';
import 'package:flutter/material.dart';

class WallComponent extends SpriteComponent {
  final WallType type;
  final Direction? direction;
  late ShapeHitbox hitbox;
  final double? shapeSize;

  WallComponent(
      {required this.type, this.direction, super.position, this.shapeSize})
      : super(size: Vector2.all(shapeSize ?? 40));
  @override
  Future<void> onLoad() async {
    anchor = Anchor.center;
    Map<WallType, String> sprites = {
      WallType.cross1: Sprites.wallCross1,
      WallType.edge1: Sprites.wallEdge1,
      WallType.long1: Sprites.wallLong1
    };
    sprite = await Sprite.load(sprites[type] ?? Sprites.wallLong1);
    if (direction == Direction.left) {
      angle = -pi / 2;
    } else if (direction == Direction.down) {
      angle = pi * 3 / 2;
    } else if (direction == Direction.up) {
      angle = pi;
    } else if (direction == Direction.right) {
      angle = pi / 2;
    }
    //hitbox = RectangleHitbox(position: position, isSolid: true);
    // final defaultPaint = Paint()
    //   ..color = Colors.red
    //   ..style = PaintingStyle.stroke;

    // hitbox = RectangleHitbox(isSolid: true)
    //   ..paint = defaultPaint
    //   ..renderShape = true;
    // add(hitbox);
  }

  // @override
  // void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
  //   debugPrint("$other");
  //   if (other is PacmanComponent) {}
  //   super.onCollision(intersectionPoints, other);
  // }
}
