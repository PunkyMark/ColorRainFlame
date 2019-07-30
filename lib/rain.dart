import 'dart:ui';
import 'package:langaw/langaw-game.dart';// Access to screen size
import 'dart:math';
import 'package:flame/sprite.dart';
import 'package:langaw/view.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:langaw/home-view.dart';
// Rect instances are immutable. However its shift and translate methods can be used to move it.
class Rain {
  final LangawGame game;
  Rect rainRect;
  Paint rainPaint;
  bool onScreen = true;
  double x;
  double y;
  Random rnd;
  List rainXpos;
  List rainYpos;
  List colors;
  int colorGreen = 0xff6ab04c;
  int colorRed = 0xffee5253;
  int colorYellow = 0xfffeca57;
  int colorBlue = 0xff54a0ff;
  int rainColor;


  Rain(this.game) {
    colors = [colorGreen, colorRed, colorYellow, colorBlue];
    rainXpos = [
      game.tileSize,
      game.tileSize + (game.raintileSize * 2),
      game.tileSize + (game.raintileSize * 4),
      game.tileSize + (game.raintileSize * 6),
      game.tileSize + (game.raintileSize * 8),
      game.tileSize + (game.raintileSize * 10),
      game.screenSize.width - (game.tileSize * 2)
    ];
    rainYpos = [
      game.tileSize,
      game.tileSize * -1,
      game.tileSize * -3,
      game.tileSize * -5,
      game.tileSize * -7,
      game.tileSize * -9,
      game.tileSize * -11
    ];
    rnd = Random();
    double x = rainXpos[rnd.nextInt(rainXpos.length)];
    double y = rainYpos[rnd.nextInt(rainYpos.length)];
    this.y = y;
    this.x = x;
    rainRect = Rect.fromLTWH(x, y, game.raintileSize, game.raintileSize);
    rainPaint = Paint();
    if (game.activeView == View.playing && game.beanstalk_bought == true){
      if (game.amountRain < 5) {
        rainColor = colorGreen;
      }
      else{
        rainColor = colors[rnd.nextInt(colors.length)];
      }
    }
    if (game.beanstalk_bought == false || game.activeView == View.lost|| game.activeView == View.home){
      rainColor = colors[rnd.nextInt(colors.length)];
    }
    rainPaint.color = Color(rainColor);
  }

  void render(Canvas c) {
    c.drawRect(rainRect, rainPaint);
  }

  void update(double t) {
    if (game.activeView == View.playing)
      if (y >= game.fly.y + game.tileSize - game.raintileSize) {
        onScreen = false;
        game.rains.removeWhere((Rain rain) => (rain.onScreen == false));
      }
    if (game.activeView == View.playing || game.activeView == View.home ||
        game.activeView == View.lost)
      if (onScreen) {
        y += game.raintileSize * 9 * t;
        rainRect = rainRect.translate(0, game.raintileSize * 9 * t);
      }
    if (game.activeView == View.home || game.activeView == View.lost) {
      if (y >= game.screenSize.height) {
        onScreen = false;
        game.homerains.removeWhere((Rain rain) => (rain.onScreen == false));
      }
    }
  }
}