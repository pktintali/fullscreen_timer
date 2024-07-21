import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 20,
              color: Colors.white38,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              color: Colors.white38,
              width: 20,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.white38,
              width: 20,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 20,
              color: Colors.white38,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            color: Colors.black,
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
        ],
      ),
    );
  }
}
