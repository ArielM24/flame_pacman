import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_pacman/game/components/walls/wall_component.dart';
import 'package:flame_pacman/shared/enums.dart';
import 'package:flutter/material.dart';

class WallCross extends PositionComponent {
  final List<WallComponent> walls = [];
  WallCross({super.position, super.angle});
  @override
  onLoad() {
    anchor = Anchor.center;
    walls.add(WallComponent(
      type: WallType.edge1,
      direction: Direction.left,
      position: Vector2(20, 20),
    ));
    walls.add(WallComponent(
      type: WallType.long1,
      direction: Direction.left,
      position: Vector2(60, 20),
    ));
    walls.add(WallComponent(
      type: WallType.cross1,
      direction: Direction.down,
      position: Vector2(100, 20),
    ));
    walls.add(WallComponent(
      type: WallType.long1,
      direction: Direction.left,
      position: Vector2(140, 20),
    ));
    walls.add(WallComponent(
      type: WallType.edge1,
      direction: Direction.right,
      position: Vector2(180, 20),
    ));
    walls.add(WallComponent(
      type: WallType.long1,
      position: Vector2(100, 60),
    ));
    walls.add(WallComponent(
      type: WallType.edge1,
      direction: Direction.up,
      position: Vector2(100, 100),
    ));

    for (var element in walls) {
      add(element);
    }
    final defaultPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke;

    final hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..renderShape = true;
    add(hitbox);
    size = Vector2(200, 120);
  }
}
