import 'package:flutter/material.dart';
import 'package:quiz_app/services/date_time_service.dart';
import 'package:quiz_app/services/firebase_services.dart';
import 'package:quiz_app/utils.dart/app_utils.dart';
import 'package:quiz_app/widgets/my_score_tile.dart';

class MyScoresList extends StatelessWidget {
  const MyScoresList({
    super.key,
    required this.quizId,
    required this.questionsCount,
  });

  final String quizId;
  final int questionsCount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: getMyScores(context, quizId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text(
                'No previous score. Attempt quiz to see a score.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            );
          } else {
            List<dynamic> sortedArray =
                sortListBasedOnTime((snapshot.data!['attempts'] as List));

            return ListView.separated(
              padding: EdgeInsets.only(
                bottom: MediaQuery.paddingOf(context).bottom + 90,
              ),
              itemCount: sortedArray.length,
              itemBuilder: (context, index) {
                return MyScoreTile(
                  numberOfCorrectAnswers: sortedArray[index]['correctAnswers'],
                  numberOfWrongAnswers: sortedArray[index]['wrongAnswers'],
                  questionsCount: questionsCount,
                  attemptedDateTime:
                      formattedDate(sortedArray[index]['attemptedOn']),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
            );
          }
        },
      ),
    );
  }
}
