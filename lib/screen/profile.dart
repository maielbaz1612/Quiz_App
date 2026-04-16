import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  String name;
  String password;
  Profile({super.key, required this.name, required this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Profile",style: TextStyle(color: Color(0xff231942),fontSize: 25,fontWeight: FontWeight.bold),),),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Icon(Icons.person_pin,size: 100,color: Color(0xff5e548e),),
            SizedBox(height: 20,),
            Text(name,style: TextStyle(color: Color(0xff231942),fontSize: 20,fontWeight: FontWeight.bold),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Password : ",style: TextStyle(color: Color(0xff231942),fontSize: 20,fontWeight: FontWeight.bold),),
                Text(password,style: TextStyle(color: Color(0xff5e548e),fontSize: 15,fontWeight: FontWeight.bold),),
              ],
            )
        ],),
      ),
    );
  }
}
