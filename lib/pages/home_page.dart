import 'package:flutter/material.dart';

import '../widgets/duration_picker_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: DurationPickerWidget(),
      ),
    );
  }
}
