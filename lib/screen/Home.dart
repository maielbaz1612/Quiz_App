import 'package:brainy/data/sqflite_database.dart';
import 'package:brainy/screen/achievements.dart';
import 'package:brainy/screen/create.dart';
import 'package:brainy/screen/join.dart';
import 'package:flutter/material.dart';

import 'categories.dart';

class Home extends StatefulWidget {
  final int userId;
  const Home({super.key, required this.userId});


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int points = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FutureBuilder(
                      future: SqlDatabase().getWhere('users', 'id = ?', [
                        widget.userId,
                      ]),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        var user = snapshot.data![0];
                        return Text(
                          user['name'],
                          style: TextStyle(
                            color: Color(0xff231942),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ],
                ),

                Container(
                  decoration: BoxDecoration(color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.elliptical(25, 25))),
                  padding: EdgeInsets.all(5),
                  width:100,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.yellow[600],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.star_outline_sharp,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text("${SqlDatabase.totalUserScore} pts",style: TextStyle(color: Colors.green[600]),),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Join()),
                    );
                  },
                  child: buildCard("images/join.png", "Join"),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Create()),
                    );
                  },
                  child: buildCard("images/add.png", "Create"),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Achievements(userId: widget.userId),
                      ),
                    );
                  },
                  child:
                      buildCard("images/achievements.png", "Achievements"),
                ),
              ],
            ),

            SizedBox(height: 20),

            Text(
              "Explore ➔",
              style: TextStyle(
                color: Color(0xff231942),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 200,
                ),
                children: [
                  Categories(
                    photo: "images/physics.png",
                    name: "Physics",
                    categoryId: 1,
                  ),
                  Categories(
                    photo: "images/electronics.png",
                    name: "Electronics",
                    categoryId: 2,
                  ),
                  Categories(
                    photo: "images/python.png",
                    name: "Python",
                    categoryId: 3,
                  ),
                  Categories(
                    photo: "images/cybersecurity.png",
                    name: "CyberSecurity",
                    categoryId: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(String image, String title) {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, width: 70),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              color: Color(0xff231942),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}