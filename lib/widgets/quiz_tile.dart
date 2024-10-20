import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/custom_button.dart';

class QuizTile extends StatelessWidget {
  const QuizTile({
    super.key,
    required this.quizName,
    required this.numberOfQuestions,
    required this.onTapViewQuiz,
  });

  final String quizName;
  final int numberOfQuestions;
  final VoidCallback onTapViewQuiz;

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
            quizName,
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
            'Number of questions: $numberOfQuestions',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomButton(
            onTap: onTapViewQuiz,
            title: 'View Quiz',
            titlePadding: const EdgeInsets.all(10),
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
