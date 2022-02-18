import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:space_shooter_game_app/player.dart';

const space_sprite_sheet = 'ship_L.png';

class SpaceShooterGame extends FlameGame with TapDetector {
  @override
  Future<void> onLoad() async {
    await images.load(space_sprite_sheet);

    final player = Player(
      Sprite(
        images.fromCache(space_sprite_sheet),
      ),
      Vector2(48, 48),
      size / 2,
    );

    await add(player);
    await super.onLoad();
  }
}
