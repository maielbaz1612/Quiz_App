import 'package:brainy/data/sqflite_database.dart';
import 'package:brainy/screen/quiz_screen.dart';
import 'package:flutter/material.dart';

class Join extends StatefulWidget {
  const Join({super.key});

  @override
  State<Join> createState() => _JoinState();
}

class _JoinState extends State<Join> {
  late TextEditingController code;

  @override
  void initState() {
    super.initState();
    code = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: code,
              decoration: InputDecoration(labelText: "Enter Code"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final db = SqlDatabase();

                var result = await db.getQuizByCode(code.text);

                if (result.isEmpty) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Quiz not found")));
                  return;
                }

                int quizId = result.first['id'];

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(quizId: quizId),
                  ),
                );
              },
              child: Text("Join"),
            ),
          ],
        ),
      ),
    );
  }
}
