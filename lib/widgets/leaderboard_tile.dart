import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LeaderboardTile extends StatelessWidget {
  const LeaderboardTile({
    super.key,
    required this.score,
    required this.userId,
    required this.attemptedDateTime,
    required this.userName,
    required this.rank,
  });

  final String score;
  final String userId;
  final String attemptedDateTime;
  final String userName;
  final int rank;

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = userId == FirebaseAuth.instance.currentUser!.uid;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
      decoration: ShapeDecoration(
        color: isCurrentUser ? Colors.blue[100] : Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Colors.grey[500]!,
          ),
          borderRadius: BorderRadius.circular(26),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Text(
              rank.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
            const VerticalDivider(),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCurrentUser ? 'You' : userName,
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
                  'Score: $score%',
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
          ],
        ),
      ),
    );
  }
}
