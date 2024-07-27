import 'package:flutter/material.dart';

import 'timer_widget.dart';

class DurationPickerWidget extends StatefulWidget {
  const DurationPickerWidget({super.key});

  @override
  DurationPickerWidgetState createState() => DurationPickerWidgetState();
}

class DurationPickerWidgetState extends State<DurationPickerWidget> {
  int selectedHours = 0;
  int selectedMinutes = 0;
  int selectedSeconds = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<int>(
                value: selectedHours,
                items: List.generate(23, (index) => index)
                    .map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value hours'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedHours = value!;
                  });
                },
              ),
              DropdownButton<int>(
                value: selectedMinutes,
                items: List.generate(60, (index) => index)
                    .map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value minutes'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMinutes = value!;
                  });
                },
              ),
              DropdownButton<int>(
                value: selectedSeconds,
                items: List.generate(60, (index) => index)
                    .map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value seconds'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSeconds = value!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Start your timer here
              final duration = Duration(
                hours: selectedHours,
                minutes: selectedMinutes,
                seconds: selectedSeconds,
              );
              print('Selected Duration: $duration');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TimerWidget(
                    duration: duration,
                    reverse: true,
                  ),
                ),
              );
            },
            child: const Text('Start Timer'),
          ),
        ],
      ),
    );
  }
}
