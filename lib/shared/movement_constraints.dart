class MovementConstraints {
  final double right;
  final double left;
  final double top;
  final double bottom;
  const MovementConstraints(
      {this.right = 0, this.left = 0, this.top = 0, this.bottom = 0});

  MovementConstraints copyWith({
    double? right,
    double? left,
    double? top,
    double? bottom,
  }) {
    return MovementConstraints(
        right: right ?? this.right,
        left: left ?? this.left,
        top: top ?? this.top,
        bottom: bottom ?? this.bottom);
  }
}
