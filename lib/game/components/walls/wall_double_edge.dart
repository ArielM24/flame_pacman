import 'package:flame/components.dart';
import 'package:flame_pacman/game/components/hitbox/hitboxed_component.dart';
import 'package:flame_pacman/shared/constants.dart';
import 'package:flame_pacman/shared/enums.dart';

import 'wall_component.dart';

class WallDoubleEdge extends HitboxedComponent {
  final int longLines;
  final List<WallComponent> walls = [];

  WallDoubleEdge({super.position, super.angle, this.longLines = 0});
  @override
  onLoad() {
    walls.add(WallComponent(
        type: WallType.edge1,
        direction: Direction.left,
        position:
            Vector2(Constants.spritesOffsetN(0), Constants.spritesOffsetN(0))));
    for (int i = 0; i < longLines; i++) {
      walls.add(WallComponent(
          type: WallType.long1,
          direction: Direction.right,
          position: Vector2(Constants.spritesOffsetN(walls.length),
              Constants.spritesOffsetN(0))));
    }
    walls.add(WallComponent(
        type: WallType.edge1,
        direction: Direction.right,
        position: Vector2(Constants.spritesOffsetN(walls.length),
            Constants.spritesOffsetN(0))));
    for (var element in walls) {
      add(element);
    }
    size = Vector2(Constants.spritesSize * walls.length, Constants.spritesSize);
    super.onLoad();
  }
}
