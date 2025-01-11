import 'dart:math';

import 'package:ball_run/boost.dart';
import 'package:ball_run/brick.dart';
import 'package:ball_run/data/levels.dart';
import 'package:ball_run/player.dart';
import 'package:ball_run/spike.dart';
import 'package:ball_run/star.dart';
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
        position: Vector2(0, 1000),
      ),
    );
    world.add(Brick(position: Vector2(0, 1020)));
    world.add(Brick(position: Vector2(100, 1020)));
    world.add(Brick(position: Vector2(200, 1020)));

    // loadLevel(levels[1]!);
    generateGameComponents();
  }

  void loadLevel(List<List<Map<String, dynamic>>> levelData) {
    int startFrom = 0;
    int count = levelData.length - 1;
    for (int i = startFrom; i <= count; i++) {
      for (var object in levelData[i]) {
        double x = object['p']['x'];
        double y = object['p']['y'] + 1000;

        if (object['t'] == "br") {
          world.add(Brick(position: Vector2(x, y)));
        } else if (object['t'] == "bo") {
          world.add(Boost(position: Vector2(x, y)));
        } else if (object['t'] == "sp") {
          world.add(Spike(position: Vector2(x, y)));
        } else if (object['t'] == "s") {
          world.add(Star(position: Vector2(x, y)));
        }
      }
    }
    startFrom = count;
    count = count * 2;
    generateGameComponents();
  }

  void generateGameComponents() {
    double startFrom = 0;
    double count = 100;
    late PositionComponent _lastBrick;
    double startFromX = 300;

    for (double i = startFrom; i < count; i++) {

      var randomY = Random().nextInt(5);
      var randomXSpacing = Random().nextInt(3);
      print(randomXSpacing);

      world.add(Brick(
          position: Vector2(startFromX + (100 * randomXSpacing) + (100 * i ), 1000 + (randomY * 20))),
        );
    }
    startFrom = count;
    count = count * 2;
  }
}
