import 'package:flutter/material.dart';
import 'package:quiz_app/pages/quiz_attempt_page.dart';
import 'package:quiz_app/widgets/custom_button.dart';
import 'package:quiz_app/widgets/leaderboard_scores_list.dart';
import 'package:quiz_app/widgets/my_scores_list.dart';
import 'package:quiz_app/widgets/scores_page_filter.dart';

class QuizScoresPage extends StatefulWidget {
  const QuizScoresPage({
    super.key,
    required this.quizId,
    required this.questionsCount,
    required this.quizName,
  });

  final String quizId;
  final int questionsCount;
  final String quizName;

  @override
  State<QuizScoresPage> createState() => _QuizScoresPageState();
}

class _QuizScoresPageState extends State<QuizScoresPage> {
  ValueNotifier<int?> sliding = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Scores and Leaderboard',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w500,
            height: 1,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          left: 30,
          right: 30,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScoresPageFilter(
                  groupValue: sliding.value,
                  onValueChanged: (value) {
                    setState(() {
                      sliding.value = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                if (sliding.value == 0)
                  MyScoresList(
                    quizId: widget.quizId,
                    questionsCount: widget.questionsCount,
                  ),
                if (sliding.value == 1)
                  LeaderboardScoresList(
                    quizId: widget.quizId,
                    questionsCount: widget.questionsCount,
                  ),
              ],
            ),
            Positioned(
              bottom: MediaQuery.paddingOf(context).bottom + 15,
              left: 0,
              right: 0,
              child: Center(
                child: CustomButton(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => QuizAttemptPage(
                          quizId: widget.quizId,
                          quizName: widget.quizName,
                        ),
                      ),
                    );
                  },
                  title: 'Start Quiz',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
