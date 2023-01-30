import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_pacman/shared/constants.dart';
import 'package:flame_pacman/shared/trajectory/position_helper.dart';
import 'package:flutter/painting.dart';

class GameBorders extends RectangleComponent with PositionHelper {
  @override
  FutureOr<void> onLoad() {
    final bluePaint = Paint()..color = const Color(0xff0921ff);
    paint = bluePaint;
    size = Vector2(Constants.spritesSize, Constants.spritesSize * 18);
    position = Vector2(Constants.spritesSize * 9, Constants.spritesSize);
    // add(RectangleComponent(
    //     paint: bluePaint,
    //     size: Vector2(Constants.spritesSize, Constants.spritesSize * 18),
    //     position: Vector2(Constants.spritesSize * 9, Constants.spritesSize)));
    debugMode = true;
  }
}
