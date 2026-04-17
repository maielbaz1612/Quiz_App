import 'package:brainy/data/sqflite_database.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final int userId;
  const Profile({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Profile",
          style: TextStyle(
            color: Color(0xff231942),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: SqlDatabase().getWhere('users', 'id = ?', [userId]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          var user = snapshot.data![0];
          return Center(
            child: Column(
              children: [
                SizedBox(height: 40),
                Icon(Icons.person_pin, size: 100, color: Color(0xff5e548e)),
                SizedBox(height: 20),
                Text(
                  user['name'],
                  style: TextStyle(
                    color: Color(0xff231942),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Email : ",
                      style: TextStyle(
                        color: Color(0xff231942),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Text(user['email'] + "@gmail.com",
                      style: TextStyle(
                        color: Color(0xff5e548e),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
