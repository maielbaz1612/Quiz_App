import 'package:brainy/models/option.dart';
import 'package:brainy/models/question.dart';
import 'package:brainy/models/quiz.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class SqlDatabase {
  static Database? _db;
  static int totalUserScore = 0;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'quiz.db');

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );

    await database.execute('PRAGMA foreign_keys = ON');
    return database;
  }

  Future<void> _onCreate(Database db, int version) async {
    // creating users tabel
    await db.execute('''
  CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE,
    password TEXT
  )
  ''');

    // creating categories tabel
    await db.execute('''
  CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
  )
  ''');

    // creating quizzes table
    await db.execute('''
  CREATE TABLE quizzes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    code TEXT UNIQUE,
    categoryId INTEGER NOT NULL,
    FOREIGN KEY (categoryId) REFERENCES categories(id)
  )
  ''');

    // creating questions table
    await db.execute('''
  CREATE TABLE questions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    quizId INTEGER NOT NULL,
    questionText TEXT NOT NULL,
    FOREIGN KEY (quizId) REFERENCES quizzes(id)
  )
  ''');

    // craating options table
    await db.execute('''
  CREATE TABLE options (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    questionId INTEGER NOT NULL,
    optionText TEXT NOT NULL,
    isCorrect INTEGER CHECK(isCorrect IN (0,1)),
    FOREIGN KEY (questionId) REFERENCES questions(id)
  )
  ''');

    // creating attempts table
    await db.execute('''
  CREATE TABLE attempts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    userId INTEGER NOT NULL,
    quizId INTEGER NOT NULL,
    score INTEGER,
    date TEXT,
    FOREIGN KEY (userId) REFERENCES users(id),
    FOREIGN KEY (quizId) REFERENCES quizzes(id)
  )
  ''');
  }

  Future<void> closeDB() async {
    final myDB = await db;
    await myDB.close();
  }

  // basic operations
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final myDB = await db;
    return await myDB.insert(table, data);
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    final myDB = await db;
    return await myDB.query(table);
  }

  Future<List<Map<String, dynamic>>> getWhere(
    String table,
    String where,
    List args,
  ) async {
    final myDB = await db;
    return await myDB.query(table, where: where, whereArgs: args);
  }

  Future<int> update(
    String table,
    Map<String, dynamic> data,
    String where,
    List args,
  ) async {
    final myDB = await db;
    return myDB.update(table, data, where: where, whereArgs: args);
  }

  Future<int> delete(String table, String where, List args) async {
    final myDB = await db;
    return await myDB.delete(table, where: where, whereArgs: args);
  }

  // some functions
  Future<List<Map<String, dynamic>>> getQuizByCode(String code) async {
    return await getWhere('quizzes', 'code = ?', [code]);
  }

  Future<List<Map<String, dynamic>>> getQuizzesByCategory(
    int categoryId,
  ) async {
    return await getWhere('quizzes', 'categoryId = ?', [categoryId]);
  }

  Future<List<Map<String, dynamic>>> getQuestions(int quizId) async {
    return await getWhere('questions', 'quizId = ?', [quizId]);
  }

  Future<List<Map<String, dynamic>>> getOptions(int questionId) async {
    return await getWhere('options', 'questionId = ?', [questionId]);
  }

  Future<List<Map<String, dynamic>>> getUserHistory(int userId) async {
    return await getWhere('attempts', 'userId = ?', [userId]);
  }

  Future<void> createFullQuiz(Quiz quiz) async {
    final myDB = await db;
    await myDB.transaction((txn) async {
      int quizId = await txn.insert('quizzes', quiz.toMap());

      for (Question question in quiz.questions) {
        int questionId = await txn.insert('questions', {
          'quizId': quizId,
          'questionText': question.questionText,
        });

        for (Option option in question.options) {
          await txn.insert('options', {
            'questionId': questionId,
            'optionText': option.optionText,
            'isCorrect': option.isCorrect,
          });
        }
      }
    });
  }

  Future<Quiz> getFullQuiz(int quizId) async {
    var quizMap = (await getWhere('quizzes', 'id = ?', [quizId])).first;
    var questionMaps = await getWhere('questions', 'quizId = ?', [quizId]);

    List<Question> questions = [];

    for (var question in questionMaps) {
      var optionMaps = await getWhere('options', 'questionId = ?', [
        question['id'],
      ]);

      List<Option> options = optionMaps
          .map(
            (option) => Option(
              id: option['id'] as int?,
              questionId: option['questionId'] as int,
              optionText: option['optionText'] as String,
              isCorrect: option['isCorrect'] as int,
            ),
          )
          .toList();
      questions.add(
        Question(
          id: question['id'] as int?,
          quizId: question['quizId'] as int,
          questionText: question['questionText'] as String,
          options: options,
        ),
      );
    }
    return Quiz(
      id: quizMap['id'] as int?,
      title: quizMap['title'] as String,
      description: quizMap['description'] as String,
      code: quizMap['code'] as String,
      categoryId: quizMap['categoryId'] as int,
      questions: questions,
    );
  }

  Future<void> syncTotalScore() async {
    final myDB = await db;

    var result = await myDB.rawQuery('SELECT SUM(score) as total FROM attempts');

    if (result.isNotEmpty && result.first['total'] != null) {
      SqlDatabase.totalUserScore = result.first['total'] as int;
    } else {
      SqlDatabase.totalUserScore = 0;
    }
  }

  Future<int> submitQuiz({
    required int userId,
    required int quizId,
    required Map<int, int> answers,
  }) async {
    int score = 0;

    for (var entry in answers.entries) {
      var result = await getWhere('options', 'id = ? AND isCorrect = 1', [
        entry.value,
      ]);

      if (result.isNotEmpty) score++;
    }

    await insert('attempts', {
      'userId': userId,
      'quizId': quizId,
      'score': score,
      'date': DateTime.now().toString(),
    });

    SqlDatabase.totalUserScore += score;
    return score;
  }

  // Authintication
  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final existing = await getWhere('users', 'email = ?', [email]);

    if (existing.isNotEmpty) {
      return false;
    }

    int userId = await insert('users', {
      'name': name,
      'email': email,
      'password': password,
    });

    await _saveUser(userId);
    await syncTotalScore();
    return true;
  }

  Future<bool> login({required String email, required String password}) async {
    final user = await getWhere('users', 'email = ? AND password = ?', [
      email,
      password,
    ]);

    if (user.isNotEmpty) {
      int userId = user.first['id'];
      await _saveUser(userId);
      await syncTotalScore();
      return true;
    }
    return false;
  }

  Future<void> _saveUser(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
  }

  Future<int?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    return userId != null;
  }
  Future<String> getQuizTitleById(int quizId) async {
    var result = await getWhere('quizzes', 'id = ?', [quizId]);
    if (result.isNotEmpty) {
      return result.first['title'] as String;
    }
    return "Unknown Quiz";
  }
}