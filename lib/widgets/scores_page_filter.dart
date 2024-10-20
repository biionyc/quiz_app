import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScoresPageFilter extends StatelessWidget {
  const ScoresPageFilter({
    super.key,
    required this.groupValue,
    required this.onValueChanged,
  });

  final int? groupValue;
  final void Function(int?) onValueChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
      groupValue: groupValue,
      children: {
        0: Text(
          'My Scores',
          style: TextStyle(
            color: groupValue == 0 ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            height: 1,
          ),
        ),
        1: Text(
          'Leaderboard',
          style: TextStyle(
            color: groupValue == 1 ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            height: 1,
          ),
        ),
      },
      thumbColor: Colors.blueAccent,
      onValueChanged: onValueChanged,
    );
  }
}
