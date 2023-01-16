import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'wall_component.dart';

class WallListComponent extends PositionComponent {
  final List<WallComponent> walls = [];
  WallListComponent({super.position, super.angle});
  @override
  onLoad() {
    //add(RectangleHitbox(isSolid: true));
    final hitboxes = <Vector2>[];
    for (int i = 0; i < walls.length; i++) {
      Rect r = walls[i].toRect();

      hitboxes.add(Vector2(r.topLeft.dx, r.topLeft.dy));
      hitboxes.add(Vector2(r.topRight.dx, r.topRight.dy));
      hitboxes.add(Vector2(r.bottomRight.dx, r.bottomRight.dy));
      hitboxes.add(Vector2(r.bottomLeft.dx, r.bottomLeft.dy));
    }
    final hit = PolygonHitbox(hitboxes, isSolid: true);
    hit.renderShape = true;
    final paint = Paint();
    paint.color = Colors.red;
    paint.style = PaintingStyle.stroke;
    hit.paint = paint;
    //add(hit);
    super.onLoad();
  }
}
