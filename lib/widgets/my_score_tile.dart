import 'package:flutter/material.dart';

class MyScoreTile extends StatelessWidget {
  const MyScoreTile({
    super.key,
    required this.numberOfCorrectAnswers,
    required this.numberOfWrongAnswers,
    required this.questionsCount,
    required this.attemptedDateTime,
  });

  final int numberOfCorrectAnswers;
  final int numberOfWrongAnswers;
  final int questionsCount;
  final String attemptedDateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Colors.grey[500]!,
          ),
          borderRadius: BorderRadius.circular(26),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Score: ${((numberOfCorrectAnswers / questionsCount) * 100).toStringAsFixed(2)}%',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Correct answers: $numberOfCorrectAnswers',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Wrong answers: $numberOfWrongAnswers',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            attemptedDateTime,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
