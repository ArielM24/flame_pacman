import 'package:flame/components.dart';
import 'package:flame_pacman/game/components/hitbox/hitboxed_component.dart';
import 'package:flame_pacman/game/components/walls/wall_component.dart';
import 'package:flame_pacman/game/components/walls/wall_list_component.dart';
import 'package:flame_pacman/shared/constants.dart';
import 'package:flame_pacman/shared/enums.dart';

class WallCross extends WallListComponent {
  WallCross({super.position, super.angle});
  @override
  onLoad() {
    anchor = Anchor.center;
    walls.add(WallComponent(
      type: WallType.edge1,
      direction: Direction.left,
      position:
          Vector2(Constants.spritesOffsetN(0), Constants.spritesOffsetN(0)),
    ));
    walls.add(WallComponent(
      type: WallType.long1,
      direction: Direction.left,
      position:
          Vector2(Constants.spritesOffsetN(1), Constants.spritesOffsetN(0)),
    ));
    walls.add(WallComponent(
      type: WallType.cross1,
      direction: Direction.down,
      position:
          Vector2(Constants.spritesOffsetN(2), Constants.spritesOffsetN(0)),
    ));
    walls.add(WallComponent(
      type: WallType.long1,
      direction: Direction.left,
      position:
          Vector2(Constants.spritesOffsetN(3), Constants.spritesOffsetN(0)),
    ));
    walls.add(WallComponent(
      type: WallType.edge1,
      direction: Direction.right,
      position:
          Vector2(Constants.spritesOffsetN(4), Constants.spritesOffsetN(0)),
    ));
    walls.add(WallComponent(
      type: WallType.long1,
      position:
          Vector2(Constants.spritesOffsetN(2), Constants.spritesOffsetN(1)),
    ));
    walls.add(WallComponent(
      type: WallType.edge1,
      direction: Direction.up,
      position:
          Vector2(Constants.spritesOffsetN(2), Constants.spritesOffsetN(2)),
    ));

    for (var element in walls) {
      add(element);
    }
    size = Vector2(Constants.spritesSize * 5, Constants.spritesSize * 3);
    //debugMode = true;
    super.onLoad();
  }
}
