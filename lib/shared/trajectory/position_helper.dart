import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_pacman/shared/enums.dart';
import 'package:flutter/foundation.dart';

mixin PositionHelper on PositionComponent {
  double get halfWidth => size.x / 2;

  double get halfHeight => size.y / 2;

  Vector2 get realTopLeftPosition {
    final aux = absoluteTopLeftPosition.clone();
    aux.rotate(-absoluteAngle, center: absoluteCenter);
    return aux;
  }

  double get relativeRightEdge {
    return topLeftPosition.x + size.x;
  }

  double get relativeLeftEdge {
    return topLeftPosition.x;
  }

  double get relativeTopEdge {
    return topLeftPosition.y;
  }

  double get relativeBottomEdge {
    return topLeftPosition.y + size.y;
  }

  double get rightEdge {
    return realTopLeftPosition.x + size.x;
  }

  double get leftEdge {
    return realTopLeftPosition.x;
  }

  double get topEdge {
    return realTopLeftPosition.y;
  }

  double get bottomEdge {
    return realTopLeftPosition.y + size.y;
  }

  Vector2 get rightCenterPosition {
    return Vector2(rightEdge, topEdge + halfHeight);
  }

  Vector2 get leftCenterPosition {
    return Vector2(leftEdge, topEdge + halfHeight);
  }

  Vector2 get bottomCenterPosition {
    return Vector2(leftEdge + halfWidth, bottomEdge);
  }

  Vector2 get topCenterPosition {
    return Vector2(leftEdge + halfWidth, topEdge);
  }

  Vector2 get topRightPosition {
    return Vector2(leftEdge + size.x, topEdge);
  }

  Vector2 get bottomRightPosition {
    return Vector2(leftEdge + size.x, bottomEdge);
  }

  Vector2 get bottomLeftPosition {
    return Vector2(leftEdge, bottomEdge);
  }

  double leftToEdge(PositionHelper component, [double offset = 1]) {
    return component.leftEdge - halfWidth - offset;
  }

  double rightToEdge(PositionHelper component, [double offset = 1]) {
    return component.rightEdge + halfWidth + offset;
  }

  double bottomToEdge(PositionHelper component, [double offset = 1]) {
    return component.bottomEdge + halfWidth + offset;
  }

  double topToEdge(PositionHelper component, [double offset = 1]) {
    return component.topEdge - halfWidth - offset;
  }
}
