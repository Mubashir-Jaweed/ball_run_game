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
   double _moveSpeed = 350.0;
  final double playerRadius;

  void onMount() {
    size = Vector2.all(playerRadius * 2);
    anchor = Anchor.center;
    super.onMount();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(CircleHitbox(
      anchor: anchor,
      radius: playerRadius,
      collisionType: CollisionType.active,
    ));
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

    if (other is Brick) {
      if (other.y > position.y) {
        _velocity.y = 0;
        position.y = other.position.y - other.height;
      } else if (other.y == position.y && other.x > position.x) {
        _velocity.x = 0.0;
        // _moveSpeed = 0;

        position.x = other.position.x - (other.width / 2) - playerRadius ;
      }
    }
  }

  void jump() {
    _velocity.y = -_jumpSpeed;
  }
}
