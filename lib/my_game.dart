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

    camera.viewport =
        FixedResolutionViewport(resolution: Vector2(size.x, size.y));

    // camera.viewfinder.zoom = 0.5;
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    debugMode = true;
    _initializeGame();
  }

  @override
  void update(double dt) {
    super.update(dt);

    final cameraX = camera.viewfinder.position.x;
    final playerX = myPlayer.position.x;
    const double offset = 100.0;

    camera.viewfinder.position = Vector2(
      playerX,
      0,
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
        position: Vector2(0, 0),
      ),
    );

    for (int i = 0; i <= 10; i++) {
      world.add(brick = Brick(
        position: Vector2(i * 100, 100),
        sizeX: 100,
      ));
    }
  
    for (int i = 0; i <= 5; i++) {
      world.add(brick = Brick(
        position: Vector2((i * 100) +1000, 120),
        sizeX: 100,
      ));
    }
    for (int i = 0; i <= 10; i++) {
      world.add(brick = Brick(
        position: Vector2((i * 100) +1500, 90),
        sizeX: 100,
      ));
    }
  }
}
