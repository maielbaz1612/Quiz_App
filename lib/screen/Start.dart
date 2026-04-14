import 'package:brainy/screen/Home.dart';
import 'package:flutter/material.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/start.png",height: 300,),
            SizedBox(height: 80,),
            Text("Ready to learn something you didn't know \ntwo minutes ago?",style: TextStyle(color: Colors.grey[700],fontSize: 15,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Get Start ",style: TextStyle(color: Colors.deepPurple[900],fontSize: 26,fontWeight: FontWeight.bold),),
              Container(
                  decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(35)),
                  child: IconButton(onPressed: (){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
                    });
                  },color: Colors.white, icon: Icon(Icons.double_arrow_sharp)))
              ],
            )
          ],
        ),
      ),
    );
  }
}
