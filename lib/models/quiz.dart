import 'question.dart';

class Quiz {
  final int? id;
  final String title;
  final String description;
  final String code;
  final int categoryId;
  final List<Question> questions;

  Quiz({
    this.id,
    required this.title,
    required this.description,
    required this.code,
    required this.categoryId,
    this.questions = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'code': code,
      'categoryId': categoryId,
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      code: map['code'],
      categoryId: map['categoryId'],
    );
  }
}
