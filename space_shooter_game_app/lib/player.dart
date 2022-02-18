import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends SpriteComponent {
  Player(
      Sprite? sprite,
      Vector2? position,
      Vector2? size,
      ) : super(
    sprite: sprite,
    position: position,
    size: size,
  );
  Vector2 moveDirection = Vector2.zero();
  final _speed = 300.0;

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    this.position+=moveDirection.normalized()*_speed *dt;
  }

  void setMoveDirection(Vector2 newMoveDirection){
    moveDirection = newMoveDirection;
  }

}
