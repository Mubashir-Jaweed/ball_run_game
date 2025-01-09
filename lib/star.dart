import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Star extends PositionComponent with CollisionCallbacks {
  Star({
    required super.position,
  }) : super(priority: 10);

  final double _radius = 12;
  late Sprite _starSprite;

  void onMount() {
    size = Vector2.all(_radius * 2);
    anchor = Anchor.center;
    // debugMode = true;
    super.onMount();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _starSprite = await Sprite.load('star.png');
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
    _starSprite.render(
      canvas,
      position: size / 2,
      size: size,
      anchor:  Anchor.center
    );
  }
   void showCollectEffect() {
    final rnd = Random();
    Vector2 randomVector2() =>
        (Vector2.random(rnd) - Vector2.random(rnd)) * 200;
    parent!.add(
      ParticleSystemComponent(
        position: position,
        particle: Particle.generate(
            count: 10,
            lifespan: 0.8,
            generator: (i) {
              return AcceleratedParticle(
                speed: randomVector2(),
                acceleration: randomVector2(),
                child: RotatingParticle(
                  to: rnd.nextDouble() * pi * 2,
                  child: ComputedParticle(
                    renderer: (canvas, particle) {
                     
                      _starSprite.render(
                        canvas,
                        size: size  * (1- particle.progress),
                        anchor: Anchor.center,
                        overridePaint: Paint()
                          ..color = Colors.transparent.withOpacity(
                            1 - particle.progress,
                          ),
                      );
                    },
                  ),
                ),
              );
            }),
      ),
    );

   
    removeFromParent();
  }
}
