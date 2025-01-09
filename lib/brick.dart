import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Brick extends PositionComponent with CollisionCallbacks {
  Brick({
    required super.position,
    this.sizeX = 100,
  }) {
    size = Vector2(sizeX, 20);
    anchor = Anchor.topLeft;
  }

  final double sizeX;
  late Sprite _brickSprite;

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    // debugMode= true;
    debugColor = Colors.greenAccent;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _brickSprite = await Sprite.load('brick.png');
    add(RectangleHitbox(
      size: Vector2(sizeX, size.y),
      collisionType: CollisionType.passive,
    ));
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);

    // canvas.drawRect(
    //   Rect.fromLTWH(0, 0, sizeX, size.y),
    //   Paint()..color = Colors.redAccent,
    // );

    _brickSprite.render(canvas,
    size: Vector2(sizeX, size.y));
  }
}
