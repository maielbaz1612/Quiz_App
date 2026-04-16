import 'option.dart';

class Question {
  final int? id;
  final int quizId;
  final String questionText;
  final List<Option> options;

  Question({this.id, required this.quizId, required this.questionText, this.options = const []});

  Map<String, dynamic> toMap() {
    return {'id': id, 'quizId': quizId, 'questionText': questionText};
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      quizId: map['quizId'],
      questionText: map['questionText'],
    );
  }
}
