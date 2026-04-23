import 'package:brainy/data/sqflite_database.dart';
import 'package:brainy/models/quiz.dart';
import 'package:brainy/screen/score.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final int quizId;
  const QuizScreen({super.key, required this.quizId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Quiz? quiz;
  int currentIndex = 0;
  Map<int, int> answers = {};

  @override
  void initState() {
    super.initState();
    loadQuiz();
  }

  void loadQuiz() async {
    var data = await SqlDatabase().getFullQuiz(widget.quizId);
    setState(() => quiz = data);
  }

  @override
  Widget build(BuildContext context) {
    if (quiz == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    var question = quiz!.questions[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text(quiz!.title)),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(question.questionText, style: TextStyle(fontSize: 20)),

            SizedBox(height: 20),

            ...question.options.map((option) {
              bool isSelected = answers[question.id] == option.id;

              return Card(
                color: isSelected ? Colors.deepPurple : Colors.white,
                child: ListTile(
                  title: Text(
                    option.optionText,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  onTap: () {
                    if (question.id != null && option.id != null) {
                      setState(() {
                        answers[question.id!] = option.id!;
                      });
                    }
                  },
                ),
              );
            }),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                if (currentIndex < quiz!.questions.length - 1) {
                  setState(() => currentIndex++);
                } else {
                  int? userId = await SqlDatabase().getCurrentUser();

                  int score = await SqlDatabase().submitQuiz(
                    userId: userId!,
                    quizId: widget.quizId,
                    answers: answers,
                  );

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResultScreen(
                        score: score,
                        totalQuestions: quiz!.questions.length,
                      ),
                    ),
                  );
                }
              },
              child: Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
