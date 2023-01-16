import 'package:flame/components.dart';
import 'package:flame_pacman/game/components/hitbox/hitboxed_component.dart';
import 'package:flame_pacman/game/components/walls/wall_list_component.dart';
import 'package:flame_pacman/shared/constants.dart';
import 'package:flame_pacman/shared/enums.dart';

import 'wall_component.dart';

class WallEdgeLine extends WallListComponent {
  WallEdgeLine({super.position, super.angle});
  @override
  onLoad() {
    walls.add(WallComponent(
        type: WallType.long1,
        position:
            Vector2(Constants.spritesOffsetN(0), Constants.spritesOffsetN(0))));
    walls.add(WallComponent(
        type: WallType.edge1,
        direction: Direction.up,
        position:
            Vector2(Constants.spritesOffsetN(0), Constants.spritesOffsetN(1))));
    for (var element in walls) {
      add(element);
    }

    size = Vector2(Constants.spritesSize, Constants.spritesSize * 2);
    //debugMode = true;
    super.onLoad();
  }
}
