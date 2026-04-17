import 'package:brainy/screen/Start.dart';
import 'package:flutter/material.dart';

import 'data/sqflite_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = SqlDatabase();

  await db.insert('categories', {'name': 'Physics'});
  await db.insert('categories', {'name': 'Electronics'});
  await db.insert('categories', {'name': 'Python'});
  await db.insert('categories', {'name': 'CyberSecurity'});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Start(),
    );
  }
}
