import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Boost extends PositionComponent with CollisionCallbacks {
  Boost({
    required super.position,
  }) : super( priority: 10);

  final double radius = 15;
  late Sprite _boostSprite;

  void onMount() {
    size = Vector2.all(radius * 2);
    anchor = Anchor.center;
    debugMode = true;
    super.onMount();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(CircleHitbox(
        anchor: anchor,
        collisionType: CollisionType.passive,
        radius: radius,));
  }

 
}
