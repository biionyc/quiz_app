import 'package:flutter/material.dart';
import 'package:quiz_app/pages/quiz_complete_page.dart';
import 'package:quiz_app/services/firebase_services.dart';
import 'package:quiz_app/widgets/confirmation_dialog.dart';
import 'package:quiz_app/widgets/question_and_options.dart';

class QuizAttemptPage extends StatelessWidget {
  QuizAttemptPage({
    super.key,
    required this.quizId,
    required this.quizName,
  });

  final String quizId;
  final String quizName;
  final PageController _controller = PageController();
  final ValueNotifier<int> _correctAnswersCount = ValueNotifier(0);
  final ValueNotifier<int> _wrongAnswersCount = ValueNotifier(0);

  void _moveToNextQuestion(
    bool isLastQuestion,
    BuildContext context,
    String quizName,
    int questionsCount,
  ) {
    if (isLastQuestion) {
      updateUserAttempts(
        context,
        quizId,
        _correctAnswersCount.value,
        _wrongAnswersCount.value,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => QuizCompletePage(
            quizNmae: quizName,
            numberOfCorrectAnswers: _correctAnswersCount.value,
            numberOfWrongAnswers: _wrongAnswersCount.value,
            questionsCount: questionsCount,
          ),
        ),
      );
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false,
        title: Text(
          quizName,
          style: const TextStyle(
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
                return ConfirmationDialog(
                  title: 'Exit Quiz?',
                  subTitle:
                      'Are you sure you want to exit quiz? All your progress will be lost.',
                  onPressYes: Navigator.of(context).pop,
                );
              },
            ),
            icon: const Icon(
              Icons.cancel,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: getQuizDetails(context, quizId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else {
                return PageView.builder(
                  itemCount:
                      (snapshot.data!.data()!['questions'] as List).length,
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    int questionsCount =
                        (snapshot.data!.data()!['questions'] as List).length;
                    return QuestionAndOptions(
                      question: (snapshot.data!.data()!['questions']
                          as List)[index]['question'],
                      options: ((snapshot.data!.data()!['questions']
                          as List)[index]['options'] as Map<String, dynamic>),
                      onSelectOption: (selectedOption) {
                        if (selectedOption ==
                            (snapshot.data!.data()!['questions'] as List)[index]
                                ['correctOption']) {
                          _correctAnswersCount.value++;
                        } else {
                          _wrongAnswersCount.value++;
                        }
                        _moveToNextQuestion(
                          questionsCount == index + 1,
                          context,
                          snapshot.data!.data()!['quizName'],
                          (snapshot.data!.data()!['questions'] as List).length,
                        );
                      },
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
