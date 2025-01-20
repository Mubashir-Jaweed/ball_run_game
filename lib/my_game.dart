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

enum gameState { playing, pause, gameOver, menu }

class MyGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  Color backgroundColor() => const Color(0xff222222);

  late Player myPlayer;
  late Brick brick;
  late Brick _latestBrick;
  int startFrom = 0;
  int count = 2;
  final ValueNotifier<int> currentScore = ValueNotifier<int>(0);
  final ValueNotifier<gameState> currentState = ValueNotifier<gameState>(gameState.menu);

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

    final playerX = myPlayer.position.x;
    final playerY = myPlayer.position.y;
    const double offset = 100.0;

    camera.viewfinder.position = Vector2(
      playerX,
      playerY + 20,
    );

    if (playerX + 200 >= _latestBrick.x) {
      generateGameComponents();
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    // TODO: implement onTapDown
    myPlayer.jump();
    super.onTapDown(event);
  }

  void _initializeGame() {
    camera.moveTo(Vector2(0, 0));
    // camera.viewfinder.zoom = 0.1;

    world.add(
      myPlayer = Player(
        position: Vector2(0, 1000),
      ),
    );
    world.add(Brick(position: Vector2(-100, 1020)));
    world.add(Brick(position: Vector2(-200, 1020)));
    world.add(Brick(position: Vector2(0, 1020)));
    world.add(Brick(position: Vector2(100, 1020)));
    world.add(Brick(position: Vector2(200, 1020)));
    world.add(Brick(position: Vector2(300, 1020)));

    generateGameComponents();
  }

  void generateGameComponents() {
    double startFromX = 400;
    // generate random bricks
    for (int i = startFrom; i < count; i++) {
      var randomY = Random().nextInt(3);
      var randomXSpacing = Random().nextInt(3);

      world.add(
        _latestBrick = Brick(
            position: Vector2(startFromX + (100 * randomXSpacing) + (100 * i),
                1000 + (randomY * 20))),
      );
    }

    // add random built-in brick from levels
    var randomBrickSet = Random().nextInt(levels.length);
    List brickSet = levels[randomBrickSet];

    for (int j = count; j < brickSet.length + count; j++) {
      int indexOfObject = j - count;

      // loop for same x position
      for (int k = 0; k < brickSet[j - count].length; k++) {
        Map indexOfSameXObj = brickSet[indexOfObject][k];
        double y = indexOfSameXObj['p']['y'] + _latestBrick.y;
        double x = startFromX + (j * 100) + (indexOfSameXObj['p']['x'] * 100);

        if (indexOfSameXObj['t'] == "br") {
          world.add(Brick(position: Vector2(x, y)));
        } else if (indexOfSameXObj['t'] == "bo") {
          world.add(Boost(position: Vector2(x, y)));
        } else if (indexOfSameXObj['t'] == "sp") {
          world.add(Spike(position: Vector2(x, y)));
        } else if (indexOfSameXObj['t'] == "s") {
          world.add(Star(position: Vector2(x, y)));
        }
      }
    }

    startFrom = count + brickSet.length;
    count = startFrom + 2;
  }

  void increaseScore() {
    currentScore.value++;
    print(currentScore.value);
  }

  void gameOver() {
    currentState.value = gameState.gameOver;
    print('gameOver');
  }

  void pauseGame() {
    currentState.value = gameState.pause;
    pauseEngine();
  }

  void resumeGame() {
    currentState.value = gameState.playing;
    resumeEngine();
  }

  void startGame() {
    currentState.value = gameState.playing;
    currentScore.value = 0;
  }
}
