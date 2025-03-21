import 'dart:math';

import 'package:ball_run/boost.dart';
import 'package:ball_run/brick.dart';
import 'package:ball_run/controllers/home_controllers.dart';
import 'package:ball_run/controllers/music_controllers.dart';
import 'package:ball_run/data/levels.dart';
import 'package:ball_run/player.dart';
import 'package:ball_run/spike.dart';
import 'package:ball_run/star.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

enum gameState { playing, pause, gameOver, menu, reviving }

class MyGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  final HomeControllers homeControllers;
  final MusicControllers musicControllers;
  MyGame({required this.homeControllers, required this.musicControllers});
  @override
  Color backgroundColor() => const Color(0xff222222);

  late Player myPlayer;
  late Brick brick;
  late Brick _latestBrick;
  late int startFrom;
  late int count;
  late double playerLastPosition;
  final ValueNotifier<int> currentScore = ValueNotifier<int>(0);
  late int bestScore;
  final ValueNotifier<gameState> currentState =
      ValueNotifier<gameState>(gameState.menu);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final world = World();
    add(world);
    camera.viewport =
        FixedResolutionViewport(resolution: Vector2(size.x, size.y));
  }

  @override
  void onMount() {
    super.onMount();
    // debugMode = true;
    initializeGame();
  }

  @override
  void update(double dt) {
    super.update(dt);
    final playerX = myPlayer.position.x;
    final playerY = myPlayer.position.y;
    playerLastPosition = myPlayer.position.x;
    camera.viewfinder.position = Vector2(
      playerX,
      playerY + 20,
    );
    if (playerX + 100 >= _latestBrick.x) {
      generateGameComponents();
      removeAllPreviousComponents();
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    // TODO: implement onTapDown
    myPlayer.jump();
    super.onTapDown(event);
  }

  void initializeGame() async {
    startFrom = 0;
    count = 5;
    camera.moveTo(Vector2(0, 0));
    // camera.viewfinder.zoom = 0.1;

    world.add(
      myPlayer = Player(
        musicControllers:musicControllers,
        position: Vector2(0, 1012),
      ),
    );

    world.add(Brick(position: Vector2(-100, 1020)));
    world.add(Brick(position: Vector2(-200, 1020)));
    world.add(Brick(position: Vector2(0, 1020)));
    world.add(Brick(position: Vector2(100, 1020)));
    world.add(Brick(position: Vector2(200, 1020)));
    world.add(Brick(position: Vector2(300, 1020)));
    // world.add(Brick(position: Vector2(400, 1020)));
    // world.add(Brick(position: Vector2(500, 1020)));
    // world.add(Brick(position: Vector2(600, 1020)));
    // world.add(Star(position: Vector2(200, 1000)));
    // world.add(Star(position: Vector2(300, 1000)));
    // world.add(Star(position: Vector2(400, 1000)));
    // world.add(Star(position: Vector2(500, 1000)));
    // world.add(Star(position: Vector2(600, 1000)));

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
    count = startFrom + 5;
  }

  void increaseScore() {
    currentScore.value++;
  }

  void gameOver() async {
    currentState.value = gameState.gameOver;
    if (currentScore.value > bestScore) {
      bestScore = currentScore.value;
      await homeControllers.setBestScore(currentScore.value);
    }
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

  void startGame() async {
    bestScore = await homeControllers.getBestScore();
    print(bestScore);
    currentState.value = gameState.playing;
    currentScore.value = 0;
  }

  void menu() {
    resumeEngine();
    removeAllGameComponents();
    currentState.value = gameState.menu;
    currentScore.value = 0;
    initializeGame();
  }

  void restartGame() {
    removeAllGameComponents();
    currentState.value = gameState.playing;
    currentScore.value = 0;
    initializeGame();
  }

  void revivePlayer(){
     world.add(
      myPlayer = Player(
        musicControllers:musicControllers,
        position:Vector2(playerLastPosition - 200,_latestBrick.position.y + -50),
      ),
    );
    debugPrint('${_latestBrick.position.y}');
    currentState.value = gameState.reviving;
  }

  void removeAllPreviousComponents() {
    final bricks = world.children.whereType<Brick>();
    final boosts = world.children.whereType<Boost>();
    final spikes = world.children.whereType<Spike>();

    final bricksShouldBeRemoved = max(bricks.length - 20, 0);
    final boostsShouldBeRemoved = max(boosts.length - 5, 0);
    final spikesShouldBeRemoved = max(spikes.length - 5, 0);

    bricks.take(bricksShouldBeRemoved).forEach((brick) {
      if (brick.position.x + 100 < myPlayer.position.x) {
        brick.removeFromParent();
      }
    });
    spikes.take(spikesShouldBeRemoved).forEach((spike) {
      if (spike.position.x + 100 < myPlayer.position.x) {
        spike.removeFromParent();
      }
    });
    boosts.take(boostsShouldBeRemoved).forEach((boost) {
      if (boost.position.x + 100 < myPlayer.position.x) {
        boost.removeFromParent();
      }
    });

    // print(bricks.length);
  }

  void removeAllGameComponents() {
    final allComp = world.children.whereType<PositionComponent>();
    for (var comp in allComp) {
      comp.removeFromParent();
    }
  }
}
