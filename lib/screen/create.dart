import 'dart:math';

import 'package:brainy/data/sqflite_database.dart';
import 'package:brainy/models/quiz.dart';
import 'package:brainy/models/question.dart';
import 'package:brainy/models/option.dart';
import 'package:flutter/material.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final List<Question> questions = [];
  String quizCode = generateQuizCode();
  int correctIndex = 0;
  int currentPoints = 1;

  final questionController = TextEditingController();

  final List<TextEditingController> optionControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  void addNewQuestion() {
    setState(() {
      questions.add(
        Question(
          quizId: 0,
          questionText: questionController.text,
          options: List.generate(
            optionControllers.length,
            (index) => Option(
              questionId: 0,
              optionText: optionControllers[index].text,
              isCorrect: index == correctIndex ? 1 : 0,
            ),
          ),
        ),
      );

      questionController.clear();
      for (var c in optionControllers) {
        c.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [Text("Quiz Code ➔ "), Text(quizCode)]),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: questionController,
              decoration: InputDecoration(labelText: "Question"),
            ),

            SizedBox(height: 20),

            ...List.generate(
              4,
              (index) => TextField(
                controller: optionControllers[index],
                decoration: InputDecoration(labelText: "Option ${index + 1}"),
              ),
            ),

            SizedBox(height: 20),

            DropdownButton<int>(
              value: correctIndex,
              items: [0, 1, 2, 3]
                  .map(
                    (i) => DropdownMenuItem(
                      value: i,
                      child: Text("Correct: Option ${i + 1}"),
                    ),
                  )
                  .toList(),
              onChanged: (val) => setState(() => correctIndex = val!),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: addNewQuestion,
              child: Text("Add Question"),
            ),

            ElevatedButton(
              onPressed: () async {
                final db = SqlDatabase();

                Quiz quiz = Quiz(
                  title: "New Quiz",
                  description: "description",
                  code: quizCode,
                  categoryId: 1,
                  questions: questions,
                );

                await db.createFullQuiz(quiz);

                Navigator.pop(context);
              },
              child: Text("Finish"),
            ),
          ],
        ),
      ),
    );
  }
}

String generateQuizCode() {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  return String.fromCharCodes(
    Iterable.generate(
      6,
      (_) => chars.codeUnitAt(Random().nextInt(chars.length)),
    ),
  );
}
