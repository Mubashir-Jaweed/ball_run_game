import 'dart:async';
import 'dart:ui';

import 'package:ball_run/components/customRecHitBox.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Brick extends PositionComponent with CollisionCallbacks {
  Brick({
    required super.position,
    required this.sizeX,
  }) {
    size = Vector2(sizeX, 20);
    anchor = Anchor.center;
  }

  final double sizeX;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final topHitBox = CustomRectangleHitbox(
        size: Vector2(sizeX, 0.1),
        collisionType: CollisionType.passive,
        userData: 'top');

    final sideHitBox = CustomRectangleHitbox(
        size: Vector2(0.1, size.y),
        collisionType: CollisionType.passive,
        userData: 'left');

    add(topHitBox);
    add(sideHitBox);
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);

    canvas.drawRect(
        Rect.fromLTWH(0, 0, sizeX, size.y), Paint()..color = Colors.redAccent);
  }
}
