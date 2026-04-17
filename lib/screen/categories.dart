import 'package:brainy/screen/AvailableQuizes.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  final String photo;
  final String name;
  final int categoryId;

  const Categories({
    super.key,
    required this.photo,
    required this.name,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AvailableQuizzes(categoryId: categoryId, title: name),
          ),
        );
      },
      child: Card(
        color: Color(0xFF5c4d7d),
        child: Column(
          children: [
            Image.asset(photo, height: 150),
            Text(
              name,
              style: TextStyle(
                color: Colors.deepPurple[900],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
