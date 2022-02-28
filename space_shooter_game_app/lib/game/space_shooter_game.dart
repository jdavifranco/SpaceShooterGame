import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:space_shooter_game_app/game/Enemy.dart';
import 'package:space_shooter_game_app/game/EnemyManager.dart';
import 'package:space_shooter_game_app/game/knows_game_size.dart';
import 'package:space_shooter_game_app/game/player.dart';

const space_sprite_sheet = 'simpleSpace_tilesheet.png';

class SpaceShooterGame extends FlameGame with PanDetector {
  late SpriteSheet spriteSheet;
  late Player player;
  late Enemy enemy;

  Offset? _pointerStartPosition;
  Offset? _pointerCurrentPosition;

  final double _joystickRadius = 60;
  final double _deadZoneRadius = 10;

  //Runs once before entering game loop
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await images.load(space_sprite_sheet);

    final spriteSheet = SpriteSheet(
      image: images.fromCache(space_sprite_sheet),
      srcSize: Vector2.all(64),
    );
    player = Player(
      spriteSheet.getSpriteById(6),
      size / 2,
      Vector2(64, 64),
      Anchor.center,
    );

    await add(player);

    final enemyManager = EnemyManager(spriteSheet: spriteSheet);
    await add(enemyManager);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (_pointerStartPosition != null) {
      canvas.drawCircle(
        _pointerStartPosition!,
        60,
        Paint()..color = Colors.grey.withAlpha(100),
      );
    }

    if (_pointerCurrentPosition != null) {
      var delta = _pointerCurrentPosition! - _pointerStartPosition!;
      if (delta.distance > 60) {
        delta = _pointerStartPosition! +
            (Vector2(delta.dx, delta.dy).normalized() * 60).toOffset();
      } else {
        delta = _pointerCurrentPosition!;
      }
      canvas.drawCircle(
        delta,
        20,
        Paint()..color = Colors.grey.withAlpha(20),
      );
    }
  }

  @override
  void onPanStart(DragStartInfo info) {
    // TODO: implement onPanStart
    super.onPanStart(info);
    _pointerStartPosition = info.raw.globalPosition;
    _pointerCurrentPosition = info.raw.globalPosition;
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    // TODO: implement onPanUpdate
    super.onPanUpdate(info);

    _pointerCurrentPosition = info.raw.globalPosition;
    final delta = _pointerCurrentPosition! - _pointerStartPosition!;
    if (delta.distance > _deadZoneRadius) {
      player.setMoveDirection(
        Vector2(delta.dx, delta.dy),
      );
    } else {
      player.setMoveDirection(
        Vector2.zero(),
      );
    }
  }

  @override
  void onPanEnd(DragEndInfo info) {
    // TODO: implement onPanEnd
    super.onPanEnd(info);
    _pointerStartPosition = null;
    player.setMoveDirection(Vector2.zero());
  }

  @override
  void onPanCancel() {
    // TODO: implement onPanCancel
    super.onPanCancel();
    _pointerStartPosition = null;
    player.setMoveDirection(Vector2.zero());
  }

  @override
  void prepareComponent(Component c) {
    // TODO: implement prepareComponent
    super.prepareComponent(c);
    if (c is KnowsGameSize) {
      c.onResize(this.size);
    }
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    // TODO: implement onGameResize
    super.onGameResize(canvasSize);
    this.ancestors().whereType<KnowsGameSize>().forEach(
      (component) {
        component.onResize(this.size);
      },
    );
  }
}
