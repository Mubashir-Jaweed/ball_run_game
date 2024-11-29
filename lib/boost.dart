import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Boost extends PositionComponent with CollisionCallbacks {
  Boost({
    required super.position,
  });

  void onMount() {
    size = Vector2(50, 20);
    anchor = Anchor.topLeft;
    debugMode = true;
    super.onMount();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox(
      size: Vector2(200, 20),
      collisionType: CollisionType.passive,
    ));
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      Paint()..color = Colors.green,
    );
  }
}
