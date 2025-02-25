import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Boost extends PositionComponent with CollisionCallbacks {
  Boost({
    required super.position,
  }) : super(priority: 10);

  final double _radius = 15;
  late Sprite _boostSprite;

  @override
  void onMount() {
    size = Vector2.all(_radius * 2);
    anchor = Anchor.center;
    // debugMode = true;
    super.onMount();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _boostSprite = await Sprite.load('boost2.png');
    add(CircleHitbox(
      anchor: anchor,
      collisionType: CollisionType.passive,
      radius: _radius,
    ));
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);
    _boostSprite.render(
      canvas,
      size: size,
    );
  }
}
