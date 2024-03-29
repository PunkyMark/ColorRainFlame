import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:langaw/langaw-game.dart';
import 'package:flutter/painting.dart';
import 'package:langaw/view.dart';
import 'package:langaw/rain.dart';

class ShopDisplay {
  final LangawGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;
  double font;
  int color;

  ShopDisplay(this.game, this.font, this.color) {
    painter = TextPainter(textAlign: TextAlign.start, textDirection: TextDirection.ltr);

    textStyle = TextStyle(color: Color(color), fontSize: font, fontWeight: FontWeight.bold);

    position = Offset.zero;

  }

  void render(Canvas c) {
    painter.paint(c, position);
  }


  void update(String text, double x, double y) {
    painter.text = TextSpan(
      text: (text),
      style: textStyle,
    );

    painter.layout();

    position = Offset((game.screenSize.width / x) - (painter.width / x), (game.tileSize * y));
    }
}