import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_pacman/shared/constants.dart';
import 'package:flame_pacman/shared/enums.dart';
import 'package:flame_pacman/shared/sprites.dart';

class WallComponent extends SpriteComponent {
  final WallType type;
  final Direction? direction;

  WallComponent({required this.type, this.direction, super.position})
      : super(size: Vector2.all(Constants.spritesSize));
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
    add(RectangleHitbox(isSolid: true));
  }
}
