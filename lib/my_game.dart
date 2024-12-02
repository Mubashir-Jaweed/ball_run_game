import 'package:ball_run/boost.dart';
import 'package:ball_run/brick.dart';
import 'package:ball_run/player.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MyGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  Color backgroundColor() => const Color(0xff222222);

  late Player myPlayer;
  late Brick brick;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final world = World();
    add(world);
    camera.viewport =
        FixedResolutionViewport(resolution: Vector2(size.x, size.y));

    // camera.viewfinder.zoom = 0.1;
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    // debugMode = true;
    _initializeGame();
  }

  @override
  void update(double dt) {
    super.update(dt);

    final cameraX = camera.viewfinder.position.x;
    final playerX = myPlayer.position.x;
    final playerY = myPlayer.position.y;
    const double offset = 100.0;

    camera.viewfinder.position = Vector2(
      playerX,
      playerY + 20,
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    // TODO: implement onTapDown
    myPlayer.jump();
    super.onTapDown(event);
  }

  void _initializeGame() {
    camera.moveTo(Vector2(0, 0));

    world.add(
      myPlayer = Player(
        position: Vector2(0, 450),
      ),
    );

    world.add(Boost(position: Vector2(100, 500),));

    for (int i = 0; i <= 5; i++) {
      world.add(Brick(
        position: Vector2(i * 100, 500),
        sizeX: 100,
      ));
    }
    for (int i = 0; i <= 5; i++) {
      world.add(Brick(
        position: Vector2((i * 100) + 500, 500 - (i * 30)),
        sizeX: 100,
      ));
    }

    world.add(Brick(
      position: Vector2(1100, 300),
      sizeX: 1000,
    ));
    world.add(Boost(position: Vector2(2000, 300)));

    world.add(Boost(
      position: Vector2(1000, 300),
    ));
    for (int i = 0; i <= 5; i++) {
      world.add(Brick(
        position: Vector2((i * 100) + 2200, 350 + (i * 30)),
        sizeX: 100,
      ));
    }

    world.add(Brick(
      position: Vector2(2800, 500),
      sizeX: 1000,
    ));
  }
}
