import 'dart:async';

import 'package:ball_run/boost.dart';
import 'package:ball_run/brick.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent with CollisionCallbacks {
  Player({
    required super.position,
    this.playerRadius = 8,
  }) : super(
          priority: 20,
        );

  Color _color = Color(0xFFFFFF00);
  Vector2 _velocity = Vector2.zero();
  final double _gravity = 980.0;
  final double _jumpSpeed = 350.0;
  final double _moveSpeed = 250.0;
  final double playerRadius;
  int _jumpCount = 2;

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

     if (other is Boost) {
        double boostAmount = other.speed; 
      double incrementStep = boostAmount / 10; 
      int steps = 10; 
      int stepDurationMs = 50;

       Timer.periodic(
        Duration(milliseconds: stepDurationMs),
        (timer) {
          if (steps > 0) {
            _velocity.x += incrementStep;
            steps--;
          } else {
            timer.cancel();
          }
        },
      );
    }
    if (other is Brick) {
      if (other.y > position.y) {
        collideFromBottom(other);
      } else if ((other.y == position.y ||
              position.y - other.y < (other.height + (size.y / 2))) &&
          position.x < other.x) {
        collideFromRight(other);
      }
    }
    
    
  }

  void collideFromBottom(Brick other) {
      _jumpCount = 2;
    if (_velocity.y >= 0) {
      _velocity.y = 0;
      position.y = other.position.y - (size.y / 2);
    }
  }

  void collideFromRight(other) {
    _velocity.x = 0.0;

    position.x = other.position.x - (size.x / 2);
  }

  void jump() {
    if (_jumpCount >= 1) {
      _jumpCount -= 1;
      _velocity.y = -_jumpSpeed;
    }
  }
}
