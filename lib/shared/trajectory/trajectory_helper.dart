import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_pacman/shared/enums.dart';
import 'package:flutter/foundation.dart';

import 'position_helper.dart';

mixin TrajectoryHelper on PositionHelper, HasGameRef<FlameGame> {
  EdgeCollisionType get edgeCollisionType;

  double get stepCheckDistance;
  List<Vector2> get collidablePoints {
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

  List<Vector2> calculateTrajectoryPoints(
      Vector2 point, double offset, Direction direction) {
    List<Vector2> points = [];
    int steps = (offset / stepCheckDistance).truncateToDouble().toInt();
    bool checkFinalPoint = steps * stepCheckDistance != offset;

    switch (direction) {
      case Direction.up:
        for (int i = 1; i <= steps; i++) {
          points.add(Vector2(point.x, point.y + (-i) * stepCheckDistance));
        }
        if (checkFinalPoint) {
          points.add(Vector2(point.x, point.y - offset));
        }
        break;
      case Direction.down:
        for (int i = 1; i <= steps; i++) {
          points.add(Vector2(point.x, point.y + i * stepCheckDistance));
        }
        if (checkFinalPoint) {
          points.add(Vector2(point.x, point.y + offset));
        }
        break;
      case Direction.left:
        for (int i = 1; i <= steps; i++) {
          points.add(Vector2(point.x + (-i) * stepCheckDistance, point.y));
        }
        if (checkFinalPoint) {
          points.add(Vector2(point.x - offset, point.y));
        }
        break;
      case Direction.right:
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

  List<Vector2> trajectoryPointsOffset(double offset, Direction direction) {
    List<Vector2> points = [];
    for (final point in collidablePoints) {
      points.addAll(calculateTrajectoryPoints(point, offset, direction));
    }
    points.sort(
        (a, b) => a.distanceTo(position).compareTo(b.distanceTo(position)));

    return points;
  }

  double _getXPos(Direction direction, double moveOffset) {
    Map<Direction, double> xPos = {
      Direction.right: position.x + moveOffset,
      Direction.left: position.x - moveOffset,
      Direction.down: position.x,
      Direction.up: position.x
    };
    return xPos[direction] ?? 0;
  }

  double _getYPos(Direction direction, double moveOffset) {
    Map<Direction, double> yPos = {
      Direction.right: position.y,
      Direction.left: position.y,
      Direction.down: position.y + moveOffset,
      Direction.up: position.y - moveOffset
    };
    return yPos[direction] ?? 0;
  }

  double _getEdgePos(Direction direction, PositionHelper component) {
    Map<Direction, double Function(PositionHelper, [double])> edgePos = {
      Direction.right: leftToEdge,
      Direction.left: rightToEdge,
      Direction.down: topToEdge,
      Direction.up: bottomToEdge
    };
    return edgePos[direction]!(component);
  }

  Vector2 edgeSafePosition(
      double moveOffset, Function() classChecker, Direction direction) {
    bool useX =
        direction == Direction.up || direction == Direction.down ? false : true;

    final safePosition = Vector2(
        _getXPos(direction, moveOffset), _getYPos(direction, moveOffset));
    final points = trajectoryPointsOffset(moveOffset, direction);
    for (final point in points) {
      final components = game.componentsAtPoint(point);
      for (final component in components) {
        if (component is PositionHelper) {
          if (component.runtimeType == classChecker().runtimeType) {
            final aux = _getEdgePos(direction, component);
            if (useX) {
              safePosition.x = aux;
            } else {
              safePosition.y = aux;
            }
            return safePosition;
          }
        }
      }
    }
    return safePosition;
  }
}
