import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_pacman/shared/constants.dart';

import 'wall_cross.dart';
import 'wall_double_edge.dart';
import 'wall_edge_line.dart';

class GameWalls extends PositionComponent {
  @override
  onLoad() {
    final wallEdgeLine = WallEdgeLine(
        position:
            Vector2(Constants.spritesSize * 18, Constants.spritesOffsetN(1)));
    add(wallEdgeLine);

    final wallCross = WallCross(
        position:
            Vector2(Constants.spritesOffsetN(18), Constants.spritesSize * 6));
    add(wallCross);
    final wallLine1 = WallDoubleEdge(
        position:
            Vector2(Constants.spritesSize * 11, Constants.spritesOffsetN(4)));
    add(wallLine1);
    final wallCross2 = WallCross(
        position:
            Vector2(Constants.spritesOffsetN(15), Constants.spritesSize * 7),
        angle: -pi / 2);
    add(wallCross2);
    final wallCross3 = WallCross(
        position:
            Vector2(Constants.spritesOffsetN(21), Constants.spritesSize * 7),
        angle: pi / 2);
    add(wallCross3);
    final wallLine2 = WallDoubleEdge(
        position:
            Vector2(Constants.spritesSize * 24, Constants.spritesOffsetN(4)));
    add(wallLine2);
    final wallLine3 = WallDoubleEdge(
        position:
            Vector2(Constants.spritesSize * 14, Constants.spritesOffsetN(13)),
        longLines: 1,
        angle: -pi / 2);
    add(wallLine3);
    final wallLine4 = WallDoubleEdge(
        position:
            Vector2(Constants.spritesSize * 22, Constants.spritesOffsetN(13)),
        longLines: 1,
        angle: -pi / 2);
    add(wallLine4);
    final wallCross4 = WallCross(
        position:
            Vector2(Constants.spritesOffsetN(18), Constants.spritesSize * 14));
    add(wallCross4);
    final wallLine5 = WallDoubleEdge(
        position:
            Vector2(Constants.spritesSize * 20, Constants.spritesOffsetN(14)),
        longLines: 1);
    add(wallLine5);
    final wallLine6 = WallDoubleEdge(
        position:
            Vector2(Constants.spritesSize * 14, Constants.spritesOffsetN(14)),
        longLines: 1);
    add(wallLine6);
    final wallCross5 = WallCross(
        position:
            Vector2(Constants.spritesOffsetN(18), Constants.spritesSize * 18));
    add(wallCross5);
  }
}
