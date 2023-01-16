import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class HitboxedSprite extends SpriteComponent {
  Color? color;
  HitboxedSprite(
      {this.color, super.size, super.position, super.angle, super.anchor});
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
