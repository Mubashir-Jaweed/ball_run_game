import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Boost extends PositionComponent with CollisionCallbacks {
  Boost({
    required super.position,
  }): super(
    size: Vector2(100,20)
  );

  final double speed = 550;
  late Sprite _boostSprite;

  void onMount() {
    anchor = Anchor.topLeft;
    debugMode = true;
    super.onMount();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

       _boostSprite = await Sprite.load('boost.png');


    add(RectangleHitbox(
      size: Vector2(size.x, size.y),
      collisionType: CollisionType.passive,
    ));
    
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);

   _boostSprite.render(canvas,
   size: Vector2(size.x / 2, size.y));
  }
}
