import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/custom_snackbar.dart';

Future<void> signUp(
  String email,
  String password,
  BuildContext context,
) async {
  try {
    final UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print(user.user?.email);
  } on FirebaseAuthException catch (e) {
    if (context.mounted) {
      showCustomSnackBar(context, e.message ?? '');
    }
  }
}

Future<void> login(
  String email,
  String password,
  BuildContext context,
) async {
  try {
    final UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print(user.user?.email);
  } on FirebaseAuthException catch (e) {
    if (context.mounted) {
      showCustomSnackBar(context, e.message ?? '');
    }
  }
}

Future<void> logout() async {
  FirebaseAuth.instance.signOut();
}

Stream<QuerySnapshot<Map<String, dynamic>>>? getQuizList(
  BuildContext context,
) {
  try {
    final Stream<QuerySnapshot<Map<String, dynamic>>> quizes =
        FirebaseFirestore.instance.collection('quizes').snapshots();
    return quizes;
  } on FirebaseAuthException catch (e) {
    if (context.mounted) {
      showCustomSnackBar(context, e.message ?? '');
    }
    return null;
  }
}

Stream<DocumentSnapshot<Map<String, dynamic>>>? getMyScores(
  BuildContext context,
  String quizId,
) {
  try {
    var scores = FirebaseFirestore.instance
        .collection('quizes')
        .doc(quizId)
        .collection('scores')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return scores;
  } on FirebaseAuthException catch (e) {
    if (context.mounted) {
      showCustomSnackBar(context, e.message ?? '');
    }
    return null;
  }
}

Future<DocumentSnapshot<Map<String, dynamic>>?> getQuizDetails(
  BuildContext context,
  String quizId,
) async {
  try {
    final DocumentSnapshot<Map<String, dynamic>> quizes =
        await FirebaseFirestore.instance.collection('quizes').doc(quizId).get();
    return quizes;
  } on FirebaseAuthException catch (e) {
    if (context.mounted) {
      showCustomSnackBar(context, e.message ?? '');
    }
    return null;
  }
}

Future<void> updateUserAttempts(
  BuildContext context,
  String quizId,
  int correctAnswersCount,
  int wrongAnswersCount,
) async {
  try {
    final String userName =
        FirebaseAuth.instance.currentUser!.email?.split('@')[0] ?? '';
    await FirebaseFirestore.instance
        .collection('quizes')
        .doc(quizId)
        .collection('scores')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(
      {
        'attempts': FieldValue.arrayUnion(
          [
            {
              'attemptedOn': DateTime.now(),
              'correctAnswers': correctAnswersCount,
              'wrongAnswers': wrongAnswersCount,
              'userName': userName,
              'userId': FirebaseAuth.instance.currentUser!.uid,
            },
          ],
        ),
      },
      SetOptions(merge: true),
    );
  } on FirebaseAuthException catch (e) {
    if (context.mounted) {
      showCustomSnackBar(context, e.message ?? '');
    }
  }
}

Stream<QuerySnapshot<Map<String, dynamic>>>? getLeaderboardScores(
  BuildContext context,
  String quizId,
) {
  try {
    var leaderboardScores = FirebaseFirestore.instance
        .collection('quizes')
        .doc(quizId)
        .collection('scores')
        .snapshots();
    return leaderboardScores;
  } on FirebaseAuthException catch (e) {
    if (context.mounted) {
      showCustomSnackBar(context, e.message ?? '');
    }
    return null;
  }
}
