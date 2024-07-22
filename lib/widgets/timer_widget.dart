import 'dart:async';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final Duration duration;

  const TimerWidget({super.key, required this.duration});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  int _elapsedSeconds = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_elapsedSeconds < widget.duration.inSeconds) {
        setState(() {
          _elapsedSeconds++;
        });
      } else {
        _timer.cancel(); // Stop the timer when the duration ends
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Always cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Initial dimensions based on constraints
          double currentHeight = constraints.maxHeight;
          double currentWidth = constraints.maxWidth;
          double totalPixelToTravel = currentHeight * 2 + currentWidth * 2 - 80;
          

          // Calculate decrements
          double heightDecrement =
              currentHeight / (widget.duration.inSeconds / 2);
          double widthDecrement =
              currentWidth / (widget.duration.inSeconds / 2);

          // Adjust dimensions based on elapsed time
          double track4length = _elapsedSeconds <= widget.duration.inSeconds / 2
              ? currentHeight - heightDecrement * _elapsedSeconds
              : currentHeight -
                  heightDecrement * (widget.duration.inSeconds / 2);
          double track3Length = _elapsedSeconds > widget.duration.inSeconds / 2
              ? currentWidth -
                  widthDecrement *
                      (_elapsedSeconds - widget.duration.inSeconds / 2)
              : currentWidth;

          return Stack(
            children: [
              Align(
                key: const Key('track4'),
                alignment: Alignment.topLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 20,
                  width: track4length,
                  color: Colors.white,
                ),
              ),
              Align(
                key: const Key('track3'),
                alignment: Alignment.bottomLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  color: Colors.white,
                  width: 20,
                  height: track3Length - 40,
                ),
              ),
              // Align(
              //   key: const Key('track2'),
              //   alignment: Alignment.topRight,
              //   child: AnimatedContainer(
              //     duration: const Duration(milliseconds: 200),
              //     margin: const EdgeInsets.symmetric(vertical: 20),
              //     color: Colors.white,
              //     width: 20,
              //     height: height,
              //   ),
              // ),
              // Align(
              //   key: const Key('track1'),
              //   alignment: Alignment.bottomRight,
              //   child: AnimatedContainer(
              //     duration: const Duration(milliseconds: 200),
              //     height: 20,
              //     width: width,
              //     color: Colors.white,
              //   ),
              // ),
              GestureDetector(
                onDoubleTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '00:00:00',
                          style: TextStyle(
                            fontSize: 60,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
