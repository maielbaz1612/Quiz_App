import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ResultScreen({super.key, required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(totalQuestions.toDouble()/score <= 2 ?
              'https://lottie.host/dc76fcda-31b9-48e7-b0e0-271a14338c4f/ifnKT79fv9.json':
            'https://lottie.host/30b745db-1cb7-4dca-97cf-55cc1e289099/4LlGfuLFLp.json',
              width: 300,
              height: 300,
              repeat: false,
            ),

            const Text(
              "Quiz Completed!",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),

            const SizedBox(height: 20),

            Text(
              "Your Score :",
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
            ),

            Text(
              "$score / $totalQuestions",
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.amber),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("Back to Home", style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}