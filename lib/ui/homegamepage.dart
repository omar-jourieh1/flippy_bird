import 'dart:async';

import 'package:flippy_bird/ui/widget/barrier.dart';
import 'package:flippy_bird/ui/widget/bird.dart';
import 'package:flutter/material.dart';

class HomeGamePage extends StatefulWidget {
  const HomeGamePage({Key? key}) : super(key: key);

  @override
  State<HomeGamePage> createState() => _HomeGamePageState();
}

class _HomeGamePageState extends State<HomeGamePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool move = true;
  bool gameHasStarted = false;
  bool isGameOver = false;
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;
  int score = 0;
  int bestscore = 240;
  int souls = 3;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2 * time;
      setState(() {
        birdYaxis = initialHeight - height;
        move = !move;
        if (isGameOver != true) score += 1;
      });
      setState(() {
        if (barrierXone < -2.5) {
          barrierXone += 4;
        } else {
          barrierXone -= 0.05;
        }
        if (barrierXtwo < -3) {
          barrierXtwo += 4;
        } else {
          barrierXtwo -= 0.05;
        }
      });
      if (birdYaxis > 0.1 && birdYaxis > 0.5 ||
          birdYaxis < -0.5 ||
          birdYaxis < -1) {
        timer.cancel();
        gameHasStarted = false;
        isGameOver = true;
        gameOver();
      }
    });
  }

  void gameOver() {
    if (isGameOver) {
      setState(() {
        gameHasStarted = false;
        time = 0;
        initialHeight = 0;
      });
    }
    showModalBottomSheet(
        isScrollControlled: false,
        isDismissible: false,
        context: context,
        builder: (build) => Center(
              child: Container(
                height: 400,
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${souls > 0 ? 'R E P E A T' : 'G A M E  O V E R'}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 32),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.accessibility_new_sharp),
                          Text('$souls'),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);

                              setState(() {
                                birdYaxis = 0;
                                barrierXone = 1;
                                barrierXtwo = 1;
                                isGameOver = false;
                                if (score > bestscore) bestscore = score;
                                score = 0;
                              });
                            },
                            child: Column(
                              children: [
                                Text('REPEAT'),
                                Icon(
                                  Icons.refresh,
                                  size: 50,
                                  color: Colors.brown,
                                ),
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);

                              setState(() {
                                if (souls > 0) {
                                  birdYaxis = 0;
                                  isGameOver = false;
                                  souls -= 1;
                                } else {
                                  birdYaxis = 0;
                                  barrierXone = 1;
                                  barrierXtwo = 1;
                                  isGameOver = false;
                                  if (score > bestscore) bestscore = score;
                                  souls = 3;
                                }
                              });
                            },
                            child: Column(
                              children: [
                                Text('CONTUIE'),
                                Icon(
                                  Icons.play_arrow,
                                  size: 50,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted)
          jump();
        else
          startGame();
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYaxis),
                    duration: Duration(microseconds: 0),
                    color: Colors.blue,
                    child: Bird(isMove: move),
                  ),
                  Container(
                    alignment: Alignment(0, -0.3),
                    child: gameHasStarted
                        ? Text('')
                        : isGameOver
                            ? Text(
                                '',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )
                            : Text(
                                'T A P  T O  P L A Y',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                  ),
                  Barrier(
                    size: 120,
                    barrierXone: barrierXone,
                    barrierXtwo: 1.1,
                  ),
                  Barrier(
                    size: 150,
                    barrierXone: barrierXone,
                    barrierXtwo: -1.1,
                  ),
                  Barrier(
                    size: 150,
                    barrierXone: barrierXtwo + 1,
                    barrierXtwo: 1.1,
                  ),
                  Barrier(
                    size: 120,
                    barrierXone: barrierXtwo + 1,
                    barrierXtwo: -1.1,
                  ),
                  Positioned(
                      top: 10,
                      left: 10,
                      height: 50,
                      child: Row(
                        children: [
                          Icon(
                            Icons.accessibility_new_sharp,
                            color: Colors.white,
                          ),
                          Text(
                            '$souls',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
                child: Container(
              color: Colors.brown,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SCORE',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '$score Sec',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'BEST',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '${score > bestscore ? '${score} Sec' : '$bestscore Sec'}',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ))
          ],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Made by Omar Jourieh❤',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
