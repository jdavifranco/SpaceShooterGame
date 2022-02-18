import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:space_shooter_game_app/player.dart';

const space_sprite_sheet = 'ship_L.png';

class SpaceShooterGame extends FlameGame with PanDetector {
  late Player player;
  Offset? _pointerStartPosition;
  Offset? _pointerCurrentPosition;
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await images.load(space_sprite_sheet);

    player = Player(
      Sprite(
        images.fromCache(space_sprite_sheet),
      ),
      size/2,
      Vector2(64, 64),
    );
    await add(player);
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
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
      if(delta.distance > 60){
        delta = _pointerStartPosition!+ (Vector2(delta.dx, delta.dy).normalized() * 60).toOffset();
      }
      else{
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
    var delta = info.raw.delta;
    player.setMoveDirection(Vector2(delta.dx, delta.dy));
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
}
