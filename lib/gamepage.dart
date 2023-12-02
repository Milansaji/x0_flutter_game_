import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jumping_game/const.dart';

class game_page extends StatefulWidget {
  game_page({
    super.key,
  });

  @override
  State<game_page> createState() => _game_pageState();
}

class _game_pageState extends State<game_page> {
  static const maxsec = 30;
  int sec = maxsec;
  Timer? timer;
  void _start_timer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (sec > 0) {
          sec--;
        }
      });
    });
  }

  void _stop_time() {
    timer?.cancel();
  }

  void _reset_timer() {
    sec = maxsec;
    setState(() {
      result = '';
    });
  }

  List<String> display = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  List<int> matchindex = [];
  String result = '';
  bool oturn = true;
  int oscore = 0;
  int xscore = 0;
  int bfilled = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.amber,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'player 0:',
                          style: AppFonts.Score,
                        ),
                        Text(
                          oscore.toString(),
                          style: AppFonts.Score,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Column(
                      children: [
                        Text(
                          'player X:',
                          style: AppFonts.Score,
                        ),
                        Text(
                          xscore.toString(),
                          style: AppFonts.Score,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    width: 400,
                    height: 500,
                    child: Expanded(
                        child: GridView.builder(
                      itemCount: 9,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            _tapped(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Center(
                                child: Text(
                                  display[index],
                                  style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: matchindex.contains(index)
                                    ? Colors.blue
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                  ),
                ),
              ),
              Text(
                result,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildtimer(),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _stop_time();
                        _reset_timer();

                        _clear_box();
                        score_reseter();
                      },
                      child: Text('Reset'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _tapped(int index) {
    final isrunning = timer == null ? false : timer!.isActive;
    if (isrunning && sec != 0) {
      setState(() {
        if (oturn && display[index] == '') {
          display[index] = '0';
        } else {
          display[index] = 'X';
        }
        bfilled++;
        oturn = !oturn;
        _winner();
      });
    }
  }

  void _winner() {
    if (display[0] == display[1] &&
        display[0] == display[2] &&
        display[0] != '') {
      setState(() {
        result = 'Player ' + display[0] + ' WINS';
        matchindex.addAll([0, 1, 2]);

        _update_score(display[0]);

        Future.delayed(Duration(seconds: 5), () {
          _reset_timer();
          colorchanged();
          _clear_box();
          bfilled = 0;
        });
      });
    } else if (display[3] == display[4] &&
        display[3] == display[5] &&
        display[3] != '') {
      setState(() {
        result = 'Player ' + display[3] + ' WINS';
        matchindex.addAll([3, 4, 5]);

        _update_score(display[3]);
        Future.delayed(Duration(seconds: 5), () {
          _reset_timer();
          colorchanged();
          _clear_box();
          bfilled = 0;
        });
      });
    } else if (display[6] == display[7] &&
        display[6] == display[8] &&
        display[6] != '') {
      setState(() {
        result = 'Player ' + display[6] + ' WINS';
        matchindex.addAll([6, 7, 8]);

        _update_score(display[6]);
        Future.delayed(Duration(seconds: 5), () {
          _reset_timer();
          colorchanged();
          _clear_box();
          bfilled = 0;
        });
      });
    } else if (display[0] == display[3] &&
        display[0] == display[6] &&
        display[0] != '') {
      setState(() {
        result = 'Player ' + display[0] + ' WINS';
        matchindex.addAll([0, 3, 6]);

        _update_score(display[0]);
        Future.delayed(Duration(seconds: 5), () {
          _reset_timer();
          colorchanged();
          _clear_box();
          bfilled = 0;
        });
      });
    } else if (display[1] == display[4] &&
        display[1] == display[7] &&
        display[1] != '') {
      setState(() {
        result = 'Player ' + display[1] + ' WINS';
        matchindex.addAll([1, 4, 7]);

        _update_score(display[1]);
        Future.delayed(Duration(seconds: 5), () {
          _reset_timer();
          colorchanged();
          _clear_box();
          bfilled = 0;
        });
      });
    } else if (display[2] == display[5] &&
        display[2] == display[8] &&
        display[2] != '') {
      setState(() {
        result = 'Player ' + display[2] + ' WINS';
        matchindex.addAll([2, 5, 8]);

        _update_score(display[2]);
        Future.delayed(Duration(seconds: 5), () {
          _reset_timer();
          colorchanged();
          _clear_box();
          bfilled = 0;
        });
      });
    } else if (display[0] == display[4] &&
        display[0] == display[8] &&
        display[0] != '') {
      setState(() {
        result = 'Player ' + display[0] + ' WINS';
        matchindex.addAll([0, 4, 8]);

        _update_score(display[0]);
        Future.delayed(Duration(seconds: 5), () {
          _reset_timer();
          colorchanged();
          _clear_box();
          bfilled = 0;
        });
      });
    } else if (display[2] == display[4] &&
        display[2] == display[6] &&
        display[2] != '') {
      setState(() {
        result = 'Player ' + display[2] + ' WINS';
        matchindex.addAll([2, 4, 6]);

        _update_score(display[2]);
        Future.delayed(Duration(seconds: 5), () {
          _reset_timer();
          colorchanged();
          _clear_box();
          bfilled = 0;
        });
      });
    } else if (bfilled == 9) {
      setState(() {
        result = 'NOBODY WINS';
        Future.delayed(Duration(seconds: 5), () {
          _reset_timer();
        });
      });
    }
  }

  void _update_score(String winner) {
    if (winner == '0') {
      oscore++;
    } else if (winner == 'X') {
      xscore++;
    }
  }

  void _clear_box() {
    for (int i = 0; i < 9; i++) {
      setState(() {
        display[i] = '';

        result = '';
      });
    }
  }

  Widget buildtimer() {
    final isrunning = timer == null ? false : timer!.isActive;
    return isrunning
        ? SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - sec / maxsec,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                ),
                Center(
                    child: sec != 0
                        ? Text('$sec',
                            style: TextStyle(color: Colors.white, fontSize: 40))
                        : ElevatedButton(
                            onPressed: () {
                              _reset_timer();
                              _clear_box();
                              colorchanged();
                            },
                            child: Text('reset'))),
                SizedBox(
                  child: reseter(),
                )
              ],
            ),
          )
        : ElevatedButton(
            onPressed: () {
              _start_timer();
              _clear_box();
              colorchanged();
            },
            child: Text(
              'Play ',
              style: AppFonts.Title,
            ));
  }

  Widget? reseter() {
    setState(() {
      if (sec == 0) result = 'TIME OUT ';
    });
  }

  void colorchanged() {
    setState(() {
      matchindex = [];
    });
  }

  void score_reseter() {
    setState(() {
      oscore = 0;
      xscore = 0;
    });
  }
}
