import 'package:ball_run/boost.dart';
import 'package:ball_run/brick.dart';
import 'package:ball_run/player.dart';
import 'package:ball_run/spike.dart';
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
    final y = position["y"] + 1000;

    if (type == "Brick") {
      final sizeX = element["sizeX"];
      world.add(Brick(position: Vector2(x, y), sizeX: sizeX));
    } else if (type == "Boost") {
      world.add(Boost(position: Vector2(x, y)));
    }
     else if (type == "Spike") {
      world.add(Spike(position: Vector2(x, y)));
    }
  }
}

  final level1 = [
  // Ground layer
  {"type": "Brick", "position": {"x": 0, "y": 20}, "sizeX": 600},
  {"type": "Spike", "position": {"x": 300, "y": 0}},
  {"type": "Brick", "position": {"x": 500, "y": 40}, "sizeX": 200},
  
  {"type": "Brick", "position": {"x": 800, "y": 40}, "sizeX": 100},
  {"type": "Brick", "position": {"x": 900, "y": 60}, "sizeX": 100},
  {"type": "Brick", "position": {"x": 1000, "y": 80}, "sizeX": 100},
  {"type": "Brick", "position": {"x": 1100, "y": 100}, "sizeX": 100},
  
  {"type": "Brick", "position": {"x": 1300, "y": 100}, "sizeX": 100},
  {"type": "Brick", "position": {"x": 1400, "y": 100}, "sizeX": 100},

  {"type": "Brick", "position": {"x": 1500, "y": 140}, "sizeX": 100},

  {"type": "Brick", "position": {"x": 1600, "y": 100}, "sizeX": 100},
  {"type": "Brick", "position": {"x": 1700, "y": 100}, "sizeX": 400},
  {"type": "Boost", "position": {"x": 2050, "y": 60}},

  {"type": "Brick", "position": {"x": 2400, "y": 100}, "sizeX": 200},

  {"type": "Brick", "position": {"x": 2700, "y": 100}, "sizeX": 100},
  {"type": "Brick", "position": {"x": 2700, "y": 120}, "sizeX": 400},
  {"type": "Brick", "position": {"x": 2900, "y": 100}, "sizeX": 200},
];


}
