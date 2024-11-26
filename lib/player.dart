import 'dart:async';

import 'package:ball_run/brick.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent with CollisionCallbacks {
  Player({
    required super.position,
    this.playerRadius = 10,
  }) : super(
          priority: 20,
        );

  Color _color = Color(0xFFFFFF00);
  Vector2 _velocity = Vector2.zero();
  final double _gravity = 980.0;
  final double _jumpSpeed = 350.0;
  final double _moveSpeed = 150.0;
  final double playerRadius;

  void onMount() {
    size = Vector2.all(playerRadius * 2);
    anchor = Anchor.center;
    super.onMount();
  }

  @override
  void onLoad() {
    add(CircleHitbox(
      anchor: anchor,
      radius: playerRadius,
      collisionType: CollisionType.active,
    ));
    super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    position += _velocity * dt;
    _velocity.y += _gravity * dt;
    _velocity.x = _moveSpeed;
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);

    canvas.drawCircle(
      (size / 2).toOffset(),
      playerRadius,
      Paint()..color = _color,
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    print(other);
    if (other is Brick) {
      final ballCenter = absoluteCenter;
      final brickCenter = other.absoluteCenter;

      _velocity.y = 0;
      position.y = other.position.y - other.height;
    }
  }

  void jump() {
    _velocity.y = -_jumpSpeed;
  }
}
