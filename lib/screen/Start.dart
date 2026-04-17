import 'package:brainy/Navigation.dart';
import 'package:brainy/data/sqflite_database.dart';
import 'package:brainy/screen/Home.dart';
import 'package:flutter/material.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  //Login Sheet details
  void _openLoginSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Color(0xFF231942),
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 12),
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          "Hello",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 40),
                        Form(
                          child: TextFormField(
                            controller: userName,
                            decoration: InputDecoration(
                              hintText: "User Name",
                              hintStyle: TextStyle(color: Color(0xFF5e548e)),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.white30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color(0xFFE0B1CB),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Form(
                          child: TextFormField(
                            controller: password,
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(color: Color(0xFF5e548e)),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.white30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color(0xFFE0B1CB),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MaterialButton(
                              onPressed: () async {
                                final myDB = SqlDatabase();
                                bool success = await myDB.login(
                                  email: userName.text,
                                  password: password.text,
                                );
                                if (success) {
                                  int? userId = await myDB.getCurrentUser();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Navigation(userId: userId!),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Wrong email or password"),
                                    ),
                                  );
                                }
                              },
                              color: Colors.white24,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 40,
                              child: Text(
                                "SignIn",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () async {
                                final SqlDatabase myDB = SqlDatabase();
                                bool success = await myDB.signUp(
                                  name: userName.text,
                                  // email: email, // TODO: add a text field for email
                                  password: password.text, email: userName.text,
                                );
                                if (success) {
                                  int? userId = await myDB.getCurrentUser();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Navigation(userId: userId!),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Email already exists"),
                                    ),
                                  );
                                }
                              },
                              color: Colors.white24,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 40,
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFcbc0d3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/start.png", height: 300),
            SizedBox(height: 80),
            Text(
              "Ready to learn something you didn't know \ntwo minutes ago?",
              style: TextStyle(
                color: Color(0xFF5e548e),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Get Start ",
                  style: TextStyle(
                    color: Color(0xFF231942),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //to open Login Sheet
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF5e548e),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _openLoginSheet,
                  child: Icon(Icons.double_arrow_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
