import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:space_shooter_game_app/game/knows_game_size.dart';

class Player extends SpriteComponent with KnowsGameSize{
  Player(
      Sprite? sprite,
      Vector2? position,
      Vector2? size,
      Anchor? anchor,
      ) : super(
    sprite: sprite,
    position: position,
    size: size,
    anchor: anchor,
  );
  Vector2 moveDirection = Vector2.zero();
  final _speed = 300.0;

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    this.position+=moveDirection.normalized()*_speed *dt;

    this.position.clamp(Vector2.zero()+ this.size/2, gameSize -  this.size/2);
  }

  void setMoveDirection(Vector2 newMoveDirection){
    moveDirection = newMoveDirection;
  }

}
