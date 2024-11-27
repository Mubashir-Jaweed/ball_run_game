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
        position: Vector2(2700, 0),
      ),
    );

    for (int i = 0; i <= 5; i++) {
      world.add( Brick(
        position: Vector2(i * 100, 100),
        sizeX: 100,
      ));
    }
    for (int i = 0; i <= 5; i++) {
      world.add( Brick(
        position: Vector2( 1 +(i * 100) + 500, 100 -(i * 20 )),
        sizeX: 100,
      ));
    }

    world.add( Brick(
      position: Vector2(1100,0),
      sizeX: 100,
    ));
    world.add( Brick(
      position: Vector2(1200,0),
      sizeX: 100,
    ));
    world.add( Brick(
      position: Vector2(1500,0),
      sizeX: 100,
    ));
    world.add( Brick(
      position: Vector2(1600,0),
      sizeX: 100,
    ));
    world.add( Brick(
      position: Vector2(1700,0),
      sizeX: 100,
    ));
    world.add( Brick(
      position: Vector2(1800,-80),
      sizeX: 100,
    ));
    world.add( Brick(
      position: Vector2(1900,-80),
      sizeX: 100,
    ));
    world.add( Brick(
      position: Vector2(2000,0),
      sizeX: 300,
    ));
    world.add( Brick(
      position: Vector2(2300,20),
      sizeX: 200,
    ));
     for (int i = 0; i <= 5; i++) {
      world.add(Brick(
        position: Vector2(1 + (i * 100) + 2700, 100 - (i * 30)),
        sizeX: 100,
      ));
    }

    
    
  }
}
