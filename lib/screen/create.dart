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
  TextEditingController titleforQuiz = TextEditingController();
  int selectedCategory = 1;

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
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text("Quiz Code➔ "), Text(quizCode)]),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleforQuiz,
              decoration: InputDecoration(labelText: "Enter Title"),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: questionController,
              decoration: InputDecoration(
                hintText: "Question",
                hintStyle: TextStyle(color: Color(0xFF5e548e)),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color(0xFFE0B1CB),
                    width: 2,
                  ),
                ),
              ),
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

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
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
                    //
                    // DropdownButton<int>(
                    //   value: currentPoints,
                    //   items: [1, 2, 5, 10].map((int value) {
                    //     return DropdownMenuItem<int>(
                    //       value: value,
                    //       child: Text("points : $value pts"),
                    //     );
                    //   }).toList(),
                    //   onChanged: (newValue) {
                    //     setState(() {
                    //       currentPoints = newValue!;
                    //     });
                    //   },
                    // ),

                    DropdownButton<int>(
                      value: selectedCategory,

                      items: [
                        DropdownMenuItem(value: 1, child: Text("Physics")),
                        DropdownMenuItem(value: 2, child: Text("Electronics")),
                        DropdownMenuItem(value: 3, child: Text("Python")),
                        DropdownMenuItem(value: 4, child: Text("CyberSecurity")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: addNewQuestion,
              child: Text("Add Question"),
            ),

            ElevatedButton(
              onPressed: () async {
                //validation
                if (titleforQuiz.text.isEmpty || questions.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter a title and add at least one question")),
                  );
                  return;
                }

                final db = SqlDatabase();
                Quiz quiz = Quiz(
                  title: titleforQuiz.text,
                  description: "description",
                  code: quizCode,
                  categoryId: selectedCategory,
                  questions: questions,
                );

                await db.createFullQuiz(quiz);

                if(mounted){
                  Navigator.pop(context);
                }
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
