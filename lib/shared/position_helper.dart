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

enum EdgeCollisionType { fullEdge, cornersOnly, middleOnly, cornersAndMiddle }

mixin EdgeCollideHelper on PositionHelper, HasGameRef<FlameGame> {
  EdgeCollisionType get edgeCollisionType;
  double get stepCheckDistance;

  List<Vector2> get collisionPoints {
    List<Vector2> points = [];
    if (edgeCollisionType == EdgeCollisionType.fullEdge) {
    } else if (edgeCollisionType == EdgeCollisionType.cornersOnly) {
      points.add(realTopLeftPosition);
      points.add(topRightPosition);
      points.add(bottomRightPosition);
      points.add(bottomLeftPosition);
    } else if (edgeCollisionType == EdgeCollisionType.middleOnly) {
      points.add(topCenterPosition);
      points.add(rightCenterPosition);
      points.add(bottomCenterPosition);
      points.add(leftCenterPosition);
    } else if (edgeCollisionType == EdgeCollisionType.cornersAndMiddle) {
      points.add(topCenterPosition);
      points.add(rightCenterPosition);
      points.add(bottomCenterPosition);
      points.add(leftCenterPosition);
      points.add(realTopLeftPosition);
      points.add(topRightPosition);
      points.add(bottomRightPosition);
      points.add(bottomLeftPosition);
    }
    return points;
  }

  List<Vector2> calculateCollisionLinePoints(
      Vector2 point, double offset, Direction direction) {
    List<Vector2> points = [];

    switch (direction) {
      case Direction.up:
        int steps = (offset / stepCheckDistance).truncateToDouble().toInt();
        bool checkFinalPoint = steps * stepCheckDistance != offset;
        debugPrint("steps: $steps checkFinal: $checkFinalPoint");
        for (int i = 1; i <= steps; i++) {
          points.add(Vector2(point.x, point.y + (-i) * stepCheckDistance));
        }
        if (checkFinalPoint) {
          points.add(Vector2(point.x, point.y - offset));
        }
        break;
      case Direction.down:
        int steps = (offset / stepCheckDistance).truncateToDouble().toInt();
        bool checkFinalPoint = steps * stepCheckDistance != offset;
        debugPrint("steps: $steps checkFinal: $checkFinalPoint");
        for (int i = 1; i <= steps; i++) {
          points.add(Vector2(point.x, point.y + i * stepCheckDistance));
        }
        if (checkFinalPoint) {
          points.add(Vector2(point.x, point.y + offset));
        }
        break;
      case Direction.left:
        int steps = (offset / stepCheckDistance).truncateToDouble().toInt();
        bool checkFinalPoint = steps * stepCheckDistance != offset;
        debugPrint("steps: $steps checkFinal: $checkFinalPoint");
        for (int i = 1; i <= steps; i++) {
          points.add(Vector2(point.x + (-i) * stepCheckDistance, point.y));
        }
        if (checkFinalPoint) {
          points.add(Vector2(point.x - offset, point.y));
        }
        break;
      case Direction.right:
        int steps = (offset / stepCheckDistance).truncateToDouble().toInt();
        bool checkFinalPoint = steps * stepCheckDistance != offset;
        debugPrint("steps: $steps checkFinal: $checkFinalPoint");
        for (int i = 1; i <= steps; i++) {
          points.add(Vector2(point.x + i * stepCheckDistance, point.y));
        }
        if (checkFinalPoint) {
          points.add(Vector2(point.x + offset, point.y));
        }
        break;
    }
    return points;
  }

  List<Vector2> collisionPointsOffset(double offset, Direction direction) {
    List<Vector2> points = [];
    // debugPrint(
    //     "initial point: ${collisionPoints.first} offset: $offset, checkSize: $stepCheckDistance direction: $direction ");
    // final p =
    //     calculateCollisionLinePoints(collisionPoints.first, offset, direction);
    // debugPrint("check points $p");

    for (final point in collisionPoints) {
      if (direction == Direction.right) {
        points.addAll(calculateCollisionLinePoints(point, offset, direction));
      } else if (direction == Direction.left) {
        points.addAll(calculateCollisionLinePoints(point, offset, direction));
      } else if (direction == Direction.down) {
        points.addAll(calculateCollisionLinePoints(point, offset, direction));
      } else if (direction == Direction.up) {
        points.addAll(calculateCollisionLinePoints(point, offset, direction));
      }
    }
    points.sort(
        (a, b) => a.distanceTo(position).compareTo(b.distanceTo(position)));

    debugPrint(
        "collision points: ${collisionPoints.length} checkpoints: ${points.length}");
    return points;
  }

  double rightEdgeSafePosition(double moveOffset, Function() classChecker) {
    final moveToPoint = Vector2(position.x + moveOffset, position.y);
    final points = collisionPointsOffset(moveOffset, Direction.right);
    for (final point in points) {
      final components = game.componentsAtPoint(point);
      for (final component in components) {
        if (component is PositionHelper) {
          if (component.runtimeType == classChecker().runtimeType) {
            moveToPoint.x = leftToEdge(component);
            return moveToPoint.x;
          }
        }
      }
    }
    return moveToPoint.x;
  }

  double leftEdgeSafePosition(double moveOffset, Function() classChecker) {
    final moveToPoint = Vector2(position.x - moveOffset, position.y);
    final points = collisionPointsOffset(moveOffset, Direction.left);
    for (final point in points) {
      debugPrint("cheking point $point distance ${point.distanceTo(position)}");
      final components = game.componentsAtPoint(point);
      for (final component in components) {
        if (component is PositionHelper) {
          if (component.runtimeType == classChecker().runtimeType) {
            moveToPoint.x = rightToEdge(component);
            debugPrint("collision $point");
            return moveToPoint.x;
          }
        }
      }
    }
    return moveToPoint.x;
  }

  double topEdgeSafePosition(double moveOffset, Function() classChecker) {
    final moveToPoint = Vector2(position.x, position.y - moveOffset);
    final points = collisionPointsOffset(moveOffset, Direction.up);

    for (final point in points) {
      final components = game.componentsAtPoint(point);
      for (final component in components) {
        if (component is PositionHelper) {
          if (component.runtimeType == classChecker().runtimeType) {
            moveToPoint.y = bottomToEdge(component);
            return moveToPoint.y;
          }
        }
      }
    }
    return moveToPoint.y;
  }

  double bottomEdgeSafePosition(double moveOffset, Function() classChecker) {
    final moveToPoint = Vector2(position.x, position.y + moveOffset);
    final points = collisionPointsOffset(moveOffset, Direction.down);

    for (final point in points) {
      final components = game.componentsAtPoint(point);
      for (final component in components) {
        if (component is PositionHelper) {
          if (component.runtimeType == classChecker().runtimeType) {
            moveToPoint.y = topToEdge(component);
            return moveToPoint.y;
          }
        }
      }
    }
    return moveToPoint.y;
  }
}
