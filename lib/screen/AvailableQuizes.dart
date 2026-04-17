import 'package:brainy/data/sqflite_database.dart';
import 'package:brainy/screen/quiz_screen.dart';
import 'package:flutter/material.dart';

class AvailableQuizzes extends StatelessWidget {
  final int categoryId;
  final String title;

  const AvailableQuizzes({
    super.key,
    required this.categoryId,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FutureBuilder(
        future: SqlDatabase().getQuizzesByCategory(categoryId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var quizzes = snapshot.data!;

          if (quizzes.isEmpty) {
            return Center(child: Text("No quizzes here 😢"));
          }

          return ListView.builder(
            itemCount: quizzes.length,
            itemBuilder: (context, index) {
              var quiz = quizzes[index];

              return Card(
                child: ListTile(
                  title: Text(quiz['title']),
                  subtitle: Text("Code: ${quiz['code']}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(quizId: quiz['id']),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
