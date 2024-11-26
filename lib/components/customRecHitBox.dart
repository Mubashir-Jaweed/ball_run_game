import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class CustomRectangleHitbox extends RectangleHitbox {
  CustomRectangleHitbox({
    required this.userData,
    Vector2? size,
    CollisionType collisionType = CollisionType.passive,
  }) : super(size: size, collisionType: collisionType);

  final String userData; // Custom property to identify hitbox
}
