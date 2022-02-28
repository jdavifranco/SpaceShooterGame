import 'dart:math';

import 'package:flame/components.dart';
import 'package:space_shooter_game_app/game/knows_game_size.dart';

class Enemy extends SpriteComponent with KnowsGameSize {
  Enemy({
    required Sprite? sprite,
    required Vector2 position,
    required Vector2 size,
    required Anchor? anchor,
  }) : super(
          sprite: sprite,
          position: position,
          size: size,
          anchor: anchor,
        ) {
    angle = pi;
  }

  final _speed = 300.0;
  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, 1) * _speed * dt;
    if (position.y > gameSize.y) {
      removeFromParent();
    }
  }

}
