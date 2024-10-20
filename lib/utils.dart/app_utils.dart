import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/services/date_time_service.dart';

List<dynamic> sortListBasedOnTime(List<dynamic> unsortedList) {
  return List.from(unsortedList)
    ..sort((a, b) {
      DateTime dateA = (a['attemptedOn'] as Timestamp).toDate();
      DateTime dateB = (b['attemptedOn'] as Timestamp).toDate();
      return dateB.compareTo(dateA); 
    });
}

List<Map<String, dynamic>> leaderBoardSortedList(
  List<QueryDocumentSnapshot<Map<String, dynamic>>> listOfAllUsers,
  int questionsCount,
) {
  List<Map<String, dynamic>> leaderboardData = [];

  for (var doc in listOfAllUsers) {
    List<dynamic> attempts = doc.data()['attempts'];

    if (attempts.isNotEmpty) {
      attempts.sort((a, b) {
        DateTime dateA = (a['attemptedOn'] as Timestamp).toDate();
        DateTime dateB = (b['attemptedOn'] as Timestamp).toDate();
        return dateB.compareTo(dateA);
      });

      var mostRecentAttempt = attempts.first;

      double mostRecentScore =
          (mostRecentAttempt['correctAnswers'] / questionsCount) * 100;

      leaderboardData.add({
        'userId': mostRecentAttempt['userId'], 
        'score': mostRecentScore, 
        'attemptedOn': formattedDate(
            mostRecentAttempt['attemptedOn']), 
        'userName': mostRecentAttempt['userName'],
      });
    }
  }

  leaderboardData.sort((a, b) => b['score'].compareTo(a['score']));

  double? lastScore;
  int rank = 1;

  for (int i = 0; i < leaderboardData.length; i++) {
    if (lastScore == leaderboardData[i]['score']) {
      leaderboardData[i]['rank'] = rank;
    } else {
      rank = i + 1;
      leaderboardData[i]['rank'] = rank;
    }

    lastScore = leaderboardData[i]['score'];
  }

  return leaderboardData;
}
