import 'package:flutter/material.dart';
import 'package:tetris_game_flutter/screens/play-screen.dart';

void main() {
  runApp(TetrisGame());
}

class TetrisGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: PlayScreen(),
    );
  }
}