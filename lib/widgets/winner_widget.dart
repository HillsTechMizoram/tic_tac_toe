import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class WinnerCelebrate extends StatefulWidget {
  const WinnerCelebrate({Key? key}) : super(key: key);

  @override
  State<WinnerCelebrate> createState() => _WinnerCelebrateState();
}

class _WinnerCelebrateState extends State<WinnerCelebrate> {

  final _controller = ConfettiController();
  bool isPlaying = false;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment:  Alignment.center,
      children: [
        Scaffold(
          body: Center(
            child: MaterialButton(
              color: Colors.red,
              child: Text("WINNER!"),
              onPressed: () {
                if(isPlaying) {
                  _controller.stop();
                } else {
                  _controller.play();
                }
                isPlaying = !isPlaying;
              },
            ),
          ),
        ),
        ConfettiWidget(
          confettiController: _controller,
          blastDirection: -pi / 2,
          emissionFrequency: 0.2,
          gravity: 0.02,
          // colors: [
          //   Colors.redAccent
          // ],
          )
      ],
    );
  }
}
