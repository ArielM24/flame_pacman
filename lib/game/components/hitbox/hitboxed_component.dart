import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class HitboxedComponent extends PositionComponent {
  Color? color;
  HitboxedComponent(
      {this.color, super.position, super.size, super.anchor, super.angle});
  @override
  onLoad() {
    final defaultPaint = Paint()
      ..color = color ?? Colors.red
      ..style = PaintingStyle.stroke;
    final hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..renderShape = true;
    add(hitbox);
    super.onLoad();
  }
}
