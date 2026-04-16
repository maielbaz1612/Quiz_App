class Attempt {
  final int? id;
  final int userId;
  final int quizId;
  final int score;
  final String date;

  Attempt({
    this.id,
    required this.userId,
    required this.quizId,
    required this.score,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'quizId': quizId,
      'score': score,
      'date': date,
    };
  }

  factory Attempt.fromMap(Map<String, dynamic> map) {
    return Attempt(
      id: map['id'],
      userId: map['userId'],
      quizId: map['quizId'],
      score: map['score'],
      date: map['date'],
    );
  }
}
