import 'package:flutter/material.dart';

class Join extends StatefulWidget {
  const Join({super.key});

  @override
  State<Join> createState() => _JoinState();
}

class _JoinState extends State<Join> {
  @override
  Widget build(BuildContext context) {
    TextEditingController code = TextEditingController();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 70,left: 15,right: 15,bottom: 15),
        child: Column(children: [
          Form(child: TextFormField(
            controller: code,
            decoration: InputDecoration(
                hintText: "Enter Code",
                hintStyle: TextStyle(color: Color(0xFF5e548e)),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white30),)
                ,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color(0xFFE0B1CB), width: 2),)
            ),
          )),

        ],),
      ),
    );
  }
}
