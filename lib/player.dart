import 'dart:async';
import 'dart:math';

import 'package:ball_run/boost.dart';
import 'package:ball_run/brick.dart';
import 'package:ball_run/my_game.dart';
import 'package:ball_run/spike.dart';
import 'package:ball_run/star.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent with HasGameRef<MyGame>,CollisionCallbacks {
  Player({
    required super.position,
    this.playerRadius = 8,
  }) : super(
          priority: 20,
        );

  final Color _color = Color(0xFF009AFA);
  final Vector2 _velocity = Vector2.zero();
  final double _gravity = 980.0;
  final double _jumpSpeed = 350.0;
  final double _moveSpeed = 200.0;
  final double _boostSpeed = 600.0;
  final double playerRadius;
  bool _isBoostOn = false;
  int _jumpCount = 2;
  late Sprite _playerSprite;

  @override
  void onMount() {
    size = Vector2.all(playerRadius * 2);
    anchor = Anchor.center;
    // debugMode = true;
    super.onMount();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _playerSprite = await Sprite.load('player.png');
    add(CircleHitbox(
      anchor: anchor,
      radius: playerRadius,
      collisionType: CollisionType.active,
    ));
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    
    position += _velocity * dt;
    if (_isBoostOn) {
      _velocity.x = _boostSpeed;
    } else {
      if(gameRef.currentState.value == gameState.playing){
      _velocity.x = _moveSpeed;
    _velocity.y += _gravity * dt;


      }
    }
   
   

    if (position.y > 1300) {
      gameOverWithEffect();
      gameRef.gameOver();
    }
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);

    _playerSprite.render(
      canvas,
      size: size,
    );

   
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);

    if (other is Brick) {
      if (other.y > position.y) {
        collideFromBottom(other);
      } else if ((other.y == position.y ||
              position.y - other.y < (other.height + (size.y / 2))) &&
          position.x < other.x) {
        collideFromRight(other);
      }
    }

    if (other is Boost) {
      applyBoost(other);
    }

    if (other is Spike) {
      // print('game over');
      gameOverWithEffect();
      gameRef.gameOver();
    }
    if (other is Star) {
      // print('point');
      other.showCollectEffect();
      gameRef.increaseScore();
    }
  }

  void applyBoost(Boost other) {
    _isBoostOn = true;
    Future.delayed(Duration(milliseconds: 600), () {
      _isBoostOn = false;
    });
  }

  void collideFromBottom(Brick other) {
    _jumpCount = 2;
      _velocity.y = 0;
      position.y = other.position.y - (size.y / 2);
    
  }

  void collideFromRight(other) {
    _velocity.x = 0.0;
    position.x = other.position.x - (size.x / 2);
  }

  void jump() {
    if (_jumpCount >= 1) {
      _jumpCount -= 1;
      _velocity.y = -_jumpSpeed;
    }
  }

  void gameOverWithEffect() {
    final rnd = Random();
    Vector2 randomVector2() => (Vector2.random(rnd) - Vector2.random(rnd)) * 50;
    parent!.add(
      ParticleSystemComponent(
        position: position,
        particle: Particle.generate(
            count: 30,
            lifespan: 1,
            generator: (i) {
              return AcceleratedParticle(
                speed: randomVector2(),
                acceleration: randomVector2(),
                child: RotatingParticle(
                  to: rnd.nextDouble() * pi * 2,
                  child: ComputedParticle(
                    renderer: (canvas, particle) {
                      canvas.drawCircle(
                        (size / 2).toOffset(),
                        2,
                        Paint()
                          ..color = _color.withOpacity(
                            1 - particle.progress,
                          ),
                      );
                    },
                  ),
                ),
              );
            }),
      ),
    );

    removeFromParent();
  }
}
