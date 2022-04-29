import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utilities/fonts.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool ohTurn = true; //the first player is O
  List<String> displayExOh = [
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

  int ohScore = 0;
  int exScore = 0;
  int filledBoxes = 0;

  final _controller = ConfettiController(
    duration: const Duration(seconds: 1),
  );
  bool isPlaying = false;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[800],
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                children: [
                  ConfettiWidget(
                    confettiController: _controller,
                    blastDirection: -pi / 2,
                    emissionFrequency: 0.2,
                    gravity: 0.02,
                    // colors: [
                    //   Colors.redAccent
                    // ],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Player O',
                                style: myNewFontWhite,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(
                                  ohScore.toString(),
                                  style: fontWhiteNumber,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Player X',
                                style: myNewFontWhite,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(
                                  exScore.toString(),
                                  style: fontWhiteNumber,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              Expanded(
                flex: 3,
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _tapped(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 94, 94, 94))),
                          child: Center(
                            child: Text(
                              displayExOh[index],
                              //index.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 40),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Expanded(
                  child: Container(
                child: Column(
                  children: [
                    // MaterialButton(
                    //   color: Colors.red,
                    //   child: Text("WINNER!"),
                    //   onPressed: () {
                    //     if (isPlaying) {
                    //       _controller.stop();
                    //     } else {
                    //       _controller.play();
                    //     }
                    //     isPlaying = !isPlaying;
                    //   },
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        '@HillsTech.',
                        style: myNewFontWhite,
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'O';
        filledBoxes += 1;
      } else if (!ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'X';
        filledBoxes += 1;
      }
      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    //checks 1st row
    if (displayExOh[0] == displayExOh[1] &&
        displayExOh[0] == displayExOh[2] &&
        displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }

    //checks 2nd row
    if (displayExOh[3] == displayExOh[4] &&
        displayExOh[3] == displayExOh[5] &&
        displayExOh[3] != '') {
      _showWinDialog(displayExOh[3]);
    }

    //checks 3rd row
    if (displayExOh[6] == displayExOh[7] &&
        displayExOh[6] == displayExOh[8] &&
        displayExOh[6] != '') {
      _showWinDialog(displayExOh[6]);
    }

    //checks 1st column
    if (displayExOh[0] == displayExOh[3] &&
        displayExOh[0] == displayExOh[6] &&
        displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }

    //checks 2nd column
    if (displayExOh[1] == displayExOh[4] &&
        displayExOh[1] == displayExOh[7] &&
        displayExOh[1] != '') {
      _showWinDialog(displayExOh[1]);
    }

    //checks 3rd column
    if (displayExOh[2] == displayExOh[5] &&
        displayExOh[2] == displayExOh[8] &&
        displayExOh[2] != '') {
      _showWinDialog(displayExOh[2]);
    }

    //checks diagonal
    if (displayExOh[6] == displayExOh[4] &&
        displayExOh[6] == displayExOh[2] &&
        displayExOh[6] != '') {
      _showWinDialog(displayExOh[6]);
    }

    //checks diagonal
    if (displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8] &&
        displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[800],
            title: Center(
              child: Text(
                'DRAW',
                style: myNewFontWhite,
              ),
            ),
            actions: [
              MaterialButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Play Again!',
                    style: myNewFontWhite,
                  ))
            ],
          );
        });
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[800],
            title: Center(
              child: Text(
                'WINNER IS: ' + winner,
                style: myNewFontWhite,
              ),
            ),
            actions: [
              MaterialButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Play Again!',
                    style: myNewFontWhite,
                  ))
            ],
          );
        });

    if (winner == 'O') {
      _celebrateWinner();
      ohScore += 1;
    } else if (winner == 'X') {
      _celebrateWinner();
      exScore += 1;
    }
  }

  void _celebrateWinner() {
    setState(() {
      _controller.play();
      // if (isPlaying) {
      //   _controller.play();
      // } else {
      //   _controller.play();
      // }
      // isPlaying = !isPlaying;
    });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayExOh[i] = '';
      }
    });

    filledBoxes = 0;
  }
}
