import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:space_shooter_game_app/game/Enemy.dart';
import 'package:space_shooter_game_app/game/knows_game_size.dart';
import 'package:space_shooter_game_app/game/space_shooter_game.dart';

class EnemyManager extends Component
    with KnowsGameSize, HasGameRef<SpaceShooterGame> {
  EnemyManager({
    required this.spriteSheet,
  }) : super() {
    _timer = Timer(
      1,
      onTick: _spawnEnemy,
      repeat: true,
    );
  }

  late Timer _timer;
  SpriteSheet spriteSheet;
  Random random = Random();

  void _spawnEnemy() {
    Vector2 initialSize = Vector2.all(64);
    Vector2 position = Vector2(random.nextDouble() * gameSize.x, 0,)
      ..clamp(Vector2.zero() + initialSize / 2, gameSize - initialSize / 2);

    final enemy = Enemy(
      sprite: spriteSheet.getSpriteById(12),
      position: position,
      size: Vector2(64, 64),
      anchor: Anchor.center,
    );

    add(enemy);
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void onRemove() {
    super.onRemove();
    _timer.stop();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
  }
}
