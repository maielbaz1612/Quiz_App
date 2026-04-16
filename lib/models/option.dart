class Option {
  final int? id;
  final int questionId;
  final String optionText;
  final int isCorrect;

  Option({
    this.id,
    required this.questionId,
    required this.optionText,
    required this.isCorrect,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'questionId': questionId,
      'optionText': optionText,
      'isCorrect': isCorrect,
    };
  }

  factory Option.fromMap(Map<String, dynamic> map) {
    return Option(
      id: map['id'],
      questionId: map['questionId'],
      optionText: map['optionText'],
      isCorrect: map['isCorrect'],
    );
  }
}
