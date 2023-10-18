import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/palette.dart';
import 'dart:ui';

void main() async {
  final goldrush = GoldRush();

  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setPortrait();

  runApp(GameWidget(game: goldrush));
}

class GoldRush with Loadable, Game {
  static int squareSpeed = 250;

  static final squarePaint = BasicPalette.green.paint();
  static final squareWith = 100.0, squareHeight = 100.0;

  late Rect squarePos;
  int squareDirection = 1;

  late double screenWidth, screenHeight, centerX, centerY;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    screenWidth = MediaQueryData.fromWindow(window).size.width;
    screenHeight = MediaQueryData.fromWindow(window).size.height;

    centerX = (screenWidth / 2) - (squareWith / 2);
    centerY = (screenHeight / 2) - (squareHeight / 2);

    squarePos = Rect.fromLTWH(centerX, centerY, squareWith, squareHeight);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(squarePos, squarePaint);
  }

  @override
  void update(double deltaTime) {
    squarePos =
        squarePos.translate(squareSpeed * squareDirection * deltaTime, 0);

    if (squareDirection == 1 && squarePos.right > screenWidth) {
      squareDirection = -1;
    } else if (squareDirection == -1 && squarePos.left < 0) {
      squareDirection = 1;
    }
  }
}
