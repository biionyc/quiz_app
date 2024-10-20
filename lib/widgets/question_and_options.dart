import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/custom_button.dart';

class QuestionAndOptions extends StatelessWidget {
  const QuestionAndOptions({
    super.key,
    required this.question,
    required this.options,
    required this.onSelectOption,
  });

  final String question;
  final Map<String, dynamic> options;
  final void Function(String selectedOption) onSelectOption;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ...options.entries.map(
              (entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomButton(
                    title: entry.value,
                    onTap: () {
                      onSelectOption(entry.key);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
