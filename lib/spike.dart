import 'dart:math' as math;
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class Spike extends PositionComponent with CollisionCallbacks {
  Spike({
    required super.position,
  }) : super(priority: 10);

  final double _radius = 20;
  final double rotationSpeed = 5;
  late Sprite _spikeSprite;


  void onMount() {
    size = Vector2.all(_radius * 2);
    anchor = Anchor.center;
    // debugMode = true;
    super.onMount();
  }
   @override
  Future<void> onLoad() async {
    await super.onLoad();
    _spikeSprite = await Sprite.load('spike.png');

      add(
      RotateEffect.to(
        math.pi * 2,
        EffectController(
          speed: rotationSpeed,
          infinite: true,

        ),
      ),
    );
    
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
    _spikeSprite.render(
      canvas,
      size: size,
      position: size / 2,
      anchor: Anchor.center
    );
  }
}
