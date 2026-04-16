import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  String questionText;
  List<String> options;
  int correctAnswerIndex;
  int points;
  Question({super.key,required this.questionText,required this.options,required this.correctAnswerIndex,required this.points});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
