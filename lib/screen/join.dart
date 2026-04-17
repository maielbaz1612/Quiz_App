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
        padding: EdgeInsets.all(50),
        child: Column(
          children: [
            SizedBox(height: 50,),
            TextFormField(
              controller: code,
              decoration: InputDecoration(
                hintText: "Enter Code",
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

            SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                SizedBox(width: 40,),

                ElevatedButton(
                  onPressed: () {

                    Navigator.pop(context);
                  },
                  child: Text("back"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
