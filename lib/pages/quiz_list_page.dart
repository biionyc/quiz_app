import 'package:flutter/material.dart';
import 'package:quiz_app/pages/quiz_scores_page.dart';
import 'package:quiz_app/services/firebase_services.dart';
import 'package:quiz_app/widgets/confirmation_dialog.dart';
import 'package:quiz_app/widgets/quiz_tile.dart';

class QuizListPage extends StatelessWidget {
  const QuizListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Quizes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w500,
            height: 1,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return const ConfirmationDialog(
                  title: 'Sign Out?',
                  subTitle: 'Are you sure you want to sign out?',
                  onPressYes: logout,
                );
              },
            ),
            icon: const Icon(
              Icons.logout,
            ),
            color: Colors.white,
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: getQuizList(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text(
                  'No quiz available, please come back later.',
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
              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 30,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return QuizTile(
                    quizName: snapshot.data!.docs[index].data()['quizName'],
                    numberOfQuestions:
                        (snapshot.data!.docs[index].data()['questions'] as List)
                            .length,
                    onTapViewQuiz: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => QuizScoresPage(
                            quizId: snapshot.data!.docs[index].id,
                            questionsCount: (snapshot.data!.docs[index]
                                    .data()['questions'] as List)
                                .length,
                            quizName:
                                snapshot.data!.docs[index].data()['quizName'],
                          ),
                        ),
                      );
                    },
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
      ),
    );
  }
}
