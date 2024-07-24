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
  double t4 = 0;
  double t3 = 0;
  double t2 = 0;
  double t1 = 0;
  double decrementPx = 0;
  double track4Length = 0;
  double track3Length = 0;
  double track2Length = 0;
  double track1Length = 0;
  bool valuesAssigned = false;

  void reduceTracksLength() {
    if (t4 > 0 && track4Length > 0) {
      if (track4Length >= decrementPx) {
        track4Length = track4Length - decrementPx;
      } else {
        track4Length = 0;
        track3Length = track3Length - (track4Length - decrementPx).abs();
      }
    } else if (t3 > 0 && track3Length > 0) {
      if (track3Length >= decrementPx) {
        track3Length = track3Length - decrementPx;
      } else {
        track3Length = 0;
        track2Length = track2Length - (track3Length - decrementPx).abs();
      }
    } else if (t2 > 0 && track2Length > 0) {
      if (track2Length >= decrementPx) {
        track2Length = track2Length - decrementPx;
      } else {
        track2Length = 0;
        track1Length = track1Length - (track2Length - decrementPx).abs();
      }
    } else if (t1 > 0 && track1Length > 0) {
      if (track1Length >= decrementPx) {
        track1Length = track1Length - decrementPx;
      } else {
        track1Length = 0;
      }
    } else {
      track1Length = 0;
      track2Length = 0;
      track3Length = 0;
      track4Length = 0;
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_elapsedSeconds < widget.duration.inSeconds) {
        setState(() {
          _elapsedSeconds++;
          reduceTracksLength();
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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Initial dimensions based on constraints
          double currentHeight = constraints.maxHeight;
          double currentWidth = constraints.maxWidth - 40;
          double totalPixelToTravel = (currentHeight + currentWidth) * 2;

          final pxConstant = widget.duration.inSeconds / totalPixelToTravel;

          final ht = pxConstant * currentHeight;
          final wt = pxConstant * currentWidth;

          final pxReduction = 1 / pxConstant;

          //!Might new need to change each time on screen adjustment so put inside the if
          decrementPx = pxReduction;
          print(totalPixelToTravel / pxReduction);
          print('Track4Length $track4Length');
          print('Track3Length $track3Length');
          print('Track2Length $track2Length');
          print('Track1Length $track1Length');
          print('ElapsedSeconds $_elapsedSeconds');

          //On initial launch set track lengths if any track lengths is null
          // if (t1 == 0) {
          if (!valuesAssigned) {
            t4 = wt;
            t3 = ht;
            t2 = wt;
            t1 = ht;
            track4Length = currentWidth;
            track3Length = currentHeight;
            track2Length = currentWidth;
            track1Length = currentHeight;
            valuesAssigned = true;
          }
          // }

          return Stack(
            children: [
              Align(
                key: const Key('track4'),
                alignment: Alignment.topLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 20,
                  width: track4Length,
                  color: Colors.white,
                ),
              ),
              Align(
                key: const Key('track3'),
                alignment: Alignment.bottomLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  color: Colors.white,
                  width: 20,
                  height: track3Length,
                ),
              ),
              Align(
                key: const Key('track1'),
                alignment: Alignment.topRight,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  color: Colors.white,
                  width: 20,
                  height: track1Length,
                ),
              ),
              Align(
                key: const Key('track2'),
                alignment: Alignment.bottomRight,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 20,
                  width: track2Length,
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
                          (widget.duration - Duration(seconds: _elapsedSeconds))
                              .toString()
                              .split('.')
                              .first
                              .padLeft(8, '0'),
                          style: const TextStyle(
                            fontSize: 60,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '$_elapsedSeconds',
                          style: const TextStyle(color: Colors.white),
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
    );
  }
}
