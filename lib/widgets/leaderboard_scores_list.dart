import 'package:flutter/material.dart';
import 'package:quiz_app/services/firebase_services.dart';
import 'package:quiz_app/utils.dart/app_utils.dart';
import 'package:quiz_app/widgets/leaderboard_tile.dart';

class LeaderboardScoresList extends StatelessWidget {
  const LeaderboardScoresList({
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
        stream: getLeaderboardScores(context, quizId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (!snapshot.hasData ||
              (snapshot.hasData && snapshot.data!.docs.isEmpty)) {
            return const Center(
              child: Text(
                'No one has attempted this quiz till now.',
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
            List<Map<String, dynamic>> sortedLeaderBoard =
                leaderBoardSortedList(
              snapshot.data!.docs,
              questionsCount,
            );

            return ListView.separated(
              padding: EdgeInsets.only(
                bottom: MediaQuery.paddingOf(context).bottom + 90,
              ),
              itemCount: sortedLeaderBoard.length,
              itemBuilder: (context, index) {
                return LeaderboardTile(
                  score: sortedLeaderBoard[index]['score'].toStringAsFixed(2),
                  userName: sortedLeaderBoard[index]['userName'],
                  userId: sortedLeaderBoard[index]['userId'],
                  attemptedDateTime: sortedLeaderBoard[index]['attemptedOn'],
                  rank: sortedLeaderBoard[index]['rank'],
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
