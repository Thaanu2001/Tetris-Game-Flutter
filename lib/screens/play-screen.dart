import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tetris_game_flutter/calculations/move-shape.dart';
import 'package:tetris_game_flutter/calculations/random-color.dart';
import 'package:tetris_game_flutter/widgets/grid.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  List basicShapes = [
    [4, 5, 14, 15],
    [4, 14, 24, 25],
    [5, 15, 25, 24],
    [3, 4, 5, 6],
    [4, 14, 24, 34],
    [4, 5, 15, 16],
    [4, 14, 15, 25],
    [4, 13, 14, 15],
    [4, 14, 15, 24],
    [4, 5, 6, 15]
  ];
  List shape = [];
  Map<int, Color> shapeData = {};
  late Color shapeColor;
  int dropDuration = 600;
  bool gameOver = false;
  bool gameStart = false;

  @override
  void initState() {
    shape = basicShapes[Random().nextInt(basicShapes.length)];
    shapeColor = RandomColor().randomColor();
    super.initState();
    // grid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff383838),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(30, 10, 30, 50),
            child: Column(
              children: [
                Flexible(
                  child: Grid(
                    shape: (!gameStart) ? [] : shape,
                    shapeData: shapeData,
                    color: shapeColor,
                  ),
                ),
                Row(
                  children: [
                    //* Move Shape Left Button
                    if (gameStart)
                      InkWell(
                        onTap: () {
                          setState(() {
                            shape = MoveShape().moveLeft(shape, shapeData);
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: Color(0xff242424),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                              size: 30,
                            )),
                      ),
                    //* Move Fast Button
                    Flexible(
                      fit: FlexFit.tight,
                      child: InkWell(
                        onTap: () {
                          if (gameStart) {
                            setState(() {
                              dropDuration = 0;
                            });
                          } else {
                            setState(() {
                              gameStart = true;
                              grid();
                            });
                          }
                        },
                        child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xff242424),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              (!gameStart)
                                  ? Icons.play_arrow_rounded
                                  : Icons.arrow_downward_rounded,
                              color: Colors.white,
                              size: 30,
                            )),
                      ),
                    ),
                    //* Move Shape Right Button
                    if (gameStart)
                      InkWell(
                        onTap: () {
                          setState(() {
                            shape = MoveShape().moveRight(shape, shapeData);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                            color: Color(0xff242424),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
          if (gameOver)
            Container(
              width: double.infinity,
              height: double.infinity,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(30, 100, 30, 50),
                    child: Column(
                      children: [
                        Text(
                          'Game\nOver',
                          style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  //* Create shapes and drop in grid
  grid() async {
    while (shape[3] <= 189) {
      if (shapeData.containsKey(shape[0] + 10) ||
          shapeData.containsKey(shape[1] + 10) ||
          shapeData.containsKey(shape[2] + 10) ||
          shapeData.containsKey(shape[3] + 10)) {
        break;
      }
      await Future.delayed(Duration(milliseconds: dropDuration), () {
        setState(() {
          shape = [
            shape[0] + 10,
            shape[1] + 10,
            shape[2] + 10,
            shape[3] + 10,
          ];
        });
      });
    }
    shapeData[shape[0]] = shapeColor;
    shapeData[shape[1]] = shapeColor;
    shapeData[shape[2]] = shapeColor;
    shapeData[shape[3]] = shapeColor;

    if ((shapeData.containsKey(shape[0] + 10) ||
            shapeData.containsKey(shape[1] + 10) ||
            shapeData.containsKey(shape[2] + 10) ||
            shapeData.containsKey(shape[3] + 10)) &&
        shape[3] < 29) {
      setState(() {
        gameOver = true;
      });
    } else {
      dropDuration = 600;
      shape = basicShapes[Random().nextInt(basicShapes.length)];
      shapeColor = RandomColor().randomColor();
      grid();
    }
  }
}
