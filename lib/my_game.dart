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
        position: Vector2(0, 1000),
      ),
    );

    loadLevel(level1);



  
  }


  void loadLevel(List<Map<String, dynamic>> levelData) {
  for (final element in levelData) {
    final type = element["type"];
    final position = element["position"];
    final x = position["x"];
    final y = position["y"];

    if (type == "Brick") {
      final sizeX = element["sizeX"];
      world.add(Brick(position: Vector2(x, y), sizeX: sizeX));
    } else if (type == "Boost") {
      world.add(Boost(position: Vector2(x, y)));
    }
  }
}

  final level1 = [
  // Ground layer
  {"type": "Brick", "position": {"x": 0, "y": 1020}, "sizeX": 100},
  {"type": "Brick", "position": {"x": 100, "y": 1020}, "sizeX": 100},
  {"type": "Brick", "position": {"x": 200, "y": 1020}, "sizeX": 100},
  {"type": "Brick", "position": {"x": 300, "y": 1020}, "sizeX": 100},
  {"type": "Brick", "position": {"x": 400, "y": 1020}, "sizeX": 100},
  {"type": "Brick", "position": {"x": 500, "y": 1020}, "sizeX": 100},
  {"type": "Boost", "position": {"x": 550, "y": 980}},

  // First platform
  {"type": "Brick", "position": {"x": 650, "y": 900}, "sizeX": 100},
  {"type": "Brick", "position": {"x": 750, "y": 900}, "sizeX": 100},
  {"type": "Boost", "position": {"x": 800, "y": 860}},

  // Gaps and continuation
  {"type": "Brick", "position": {"x": 950, "y": 1020}, "sizeX": 100},
  {"type": "Brick", "position": {"x": 1050, "y": 1020}, "sizeX": 100},

  // Second platform
  {"type": "Brick", "position": {"x": 1150, "y": 850}, "sizeX": 100},
  {"type": "Brick", "position": {"x": 1250, "y": 850}, "sizeX": 100},
  {"type": "Boost", "position": {"x": 1300, "y": 810}},

  // Final stretch
  {"type": "Brick", "position": {"x": 1400, "y": 1020}, "sizeX": 100},
  {"type": "Brick", "position": {"x": 1500, "y": 1020}, "sizeX": 100},
  {"type": "Brick", "position": {"x": 1600, "y": 1020}, "sizeX": 100},
  {"type": "Goal", "position": {"x": 1700, "y": 980}}, // Example of a goal
];
}
