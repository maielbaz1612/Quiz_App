import 'package:brainy/data/sqflite_database.dart';
import 'package:flutter/material.dart';

class Achievements extends StatelessWidget {
  final int userId;

  const Achievements({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Achievements")),
      body: FutureBuilder(
        future: SqlDatabase().getUserHistory(userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var data = snapshot.data!;

          if (data.isEmpty) {
            return Center(child: Text("No attempts yet 😅"));
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var attempt = data[index];

              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text("Quiz ID: ${attempt['quizId']}"),
                  subtitle: Text("Score: ${attempt['score']}"),
                  trailing: Text(attempt['date'].toString().substring(0, 10)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
