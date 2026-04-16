import 'dart:math';

import 'package:brainy/screen/question.dart';
import 'package:flutter/material.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final List<Question> Questions = [];
  String quizCode = generateQuizCode();
  int CorrectIndex = 0;
  int points = 1;
  final questionController = TextEditingController();
  final List<TextEditingController> optionControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  void addNewQuestion() {
    setState(() {
      Questions.add(
          Question(
                questionText: questionController.text,
                options: optionControllers.map((c) => c.text).toList(),
                correctAnswerIndex: CorrectIndex,
                points: points,
              ));
      questionController.clear();
      for (var c in optionControllers) {
        c.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(
        children: [
          Text("Quiz Code ➔ ",style: TextStyle(color: Color(0xff231942),fontWeight: FontWeight.bold,fontSize: 20),),
          Text("$quizCode",style: TextStyle(color: Color(0xff5e548e),fontWeight: FontWeight.bold,fontSize: 15),)
        ],
      ),),
      body:SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
          TextField(
            controller: questionController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white30),)
              ,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Color(0xFFE0B1CB), width: 2),),
              labelText: "Question Text",
            labelStyle: TextStyle(color: Color(0xff231942))),
          ),
          SizedBox(height: 20,),
          ...List.generate(4, (index) => TextField(
            controller: optionControllers[index],
            decoration: InputDecoration(labelText: "Option ${index + 1}"),
          )),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Correct Answer:"),
              DropdownButton<int>(
                value: CorrectIndex,
                items: [0, 1, 2, 3].map((i) => DropdownMenuItem(value: i, child: Text("Option ${i+1}"))).toList(),
                onChanged: (val) => setState(() => CorrectIndex = val!),
              ),
            ],
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xff231942)),
            onPressed: addNewQuestion,
            child: Text("Add Another",style: TextStyle(color: Colors.white),),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xff231942)),
            onPressed: (){
              addNewQuestion();
              Navigator.pop(context);
            },
            child: Text("Finish",style: TextStyle(color: Colors.white),),
          ),

        ],),
      ),
    );
  }
}

String generateQuizCode() {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  return String.fromCharCodes(
      Iterable.generate(6, (_) => chars.codeUnitAt(Random().nextInt(chars.length))));
}
