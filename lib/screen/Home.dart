import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: "home"),
        BottomNavigationBarItem(icon: Icon(Icons.add),label: "add"),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline),label: "you"),

      ],backgroundColor: Colors.deepPurple[900],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,),
    );
  }
}
