import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_pacman/shared/assets.dart';
import 'package:flame_pacman/shared/constants.dart';
import 'package:flame_pacman/shared/trajectory/position_helper.dart';
import 'package:flame_pacman/shared/enums.dart';

class WallComponent extends SpriteComponent with PositionHelper {
  final WallType type;
  final Direction? direction;
  final bool debug;

  WallComponent({
    required this.type,
    this.debug = false,
    this.direction,
    super.position,
  }) : super(size: Vector2.all(Constants.spritesSize));
  @override
  Future<void> onLoad() async {
    anchor = Anchor.center;
    Map<WallType, String> sprites = {
      WallType.cross1: Assets.assetsImagesWallCross1.split("/").last,
      WallType.edge1: Assets.assetsImagesWallEdge1.split("/").last,
      WallType.long1: Assets.assetsImagesWallLong1.split("/").last
    };
    sprite = Sprite(await Flame.images.load(sprites[type]!));
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
    debugMode = debug;
  }
}
