import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_pacman/shared/enums.dart';
import 'package:flutter/material.dart';

import 'wall_component.dart';

class WallEdgeLine extends PositionComponent {
  List<WallComponent> walls = [];
  WallEdgeLine({super.position, super.angle});
  @override
  onLoad() {
    walls.add(WallComponent(type: WallType.long1, position: Vector2(20, 20)));
    walls.add(WallComponent(
        type: WallType.edge1,
        direction: Direction.up,
        position: Vector2(20, 60)));
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
    size = Vector2(40, 80);
  }
}
