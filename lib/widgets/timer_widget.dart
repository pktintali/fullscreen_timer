import 'dart:async';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final Duration duration;
  final bool reverse;

  const TimerWidget({super.key, required this.duration, this.reverse = false});

  @override
  TimerWidgetState createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  int _elapsedMilliseconds = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_elapsedMilliseconds < widget.duration.inMilliseconds) {
        setState(() {
          _elapsedMilliseconds += 100;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double maxWidth = constraints.maxWidth;
            double maxHeight = constraints.maxHeight;
            double trackWidth = 20.0;
            double totalPerimeter = 2 * (maxWidth + maxHeight - 2 * trackWidth);

            double progress =
                (_elapsedMilliseconds / widget.duration.inMilliseconds) *
                    totalPerimeter;

            double left = 0, top = 0, right = 0, bottom = 0;

            if (widget.reverse) {
              if (progress <= maxHeight - 2 * trackWidth) {
                right = maxHeight - trackWidth;
                bottom = maxWidth - trackWidth;
                top = maxWidth;
                left = maxHeight - progress - 2 * trackWidth;
              } else if (progress <= maxWidth + maxHeight - 3 * trackWidth) {
                right = maxHeight - trackWidth;
                left = 0;
                top = maxWidth;
                bottom = maxHeight + maxWidth - progress - 3 * trackWidth;
              } else if (progress <=
                  maxWidth + 2 * maxHeight - 4 * trackWidth) {
                bottom = 0;
                left = 0;
                top = maxWidth;
                right = 2 * maxHeight + maxWidth - progress - 4 * trackWidth;
              } else {
                bottom = 0;
                left = 0;
                right = 0;
                top = 2 * maxHeight + 2 * maxWidth - progress - 4 * trackWidth;
              }
            } else {
              if (progress <= maxWidth) {
                top = progress;
              } else if (progress <= maxWidth + maxHeight - trackWidth) {
                top = maxWidth;
                right = progress - maxWidth;
              } else if (progress <=
                  2 * maxWidth + maxHeight - 2 * trackWidth) {
                top = maxWidth;
                right = maxHeight;
                bottom = (progress - (maxWidth + maxHeight)) + trackWidth;
              } else {
                top = maxWidth;
                right = maxHeight;
                bottom = maxWidth;
                left = (progress - (2 * maxWidth + maxHeight)) + 2 * trackWidth;
              }
            }

            return Stack(
              children: [
                Align(
                  key: const Key('track4'),
                  alignment: Alignment.topLeft,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 20,
                    width: top,
                    color: Colors.white,
                  ),
                ),
                Align(
                  key: const Key('track3'),
                  alignment: Alignment.bottomLeft,
                  child: AnimatedContainer(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    duration: const Duration(milliseconds: 200),
                    color: Colors.white,
                    width: 20,
                    height: left,
                  ),
                ),
                Align(
                  key: const Key('track1'),
                  alignment: Alignment.topRight,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(top: 20),
                    color: Colors.white,
                    width: 20,
                    height: right,
                  ),
                ),
                Align(
                  key: const Key('track2'),
                  alignment: Alignment.bottomRight,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 20),
                    height: 20,
                    width: bottom,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onDoubleTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.reverse
                                ? (widget.duration -
                                        Duration(
                                            seconds:
                                                _elapsedMilliseconds ~/ 1000))
                                    .toString()
                                    .split('.')
                                    .first
                                    .padLeft(8, '0')
                                : (Duration(
                                        seconds: _elapsedMilliseconds ~/ 1000))
                                    .toString()
                                    .split('.')
                                    .first
                                    .padLeft(8, '0'),
                            style: const TextStyle(
                              fontSize: 60,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
