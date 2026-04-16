import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:brainy/screen/achievements.dart';
import 'package:brainy/screen/create.dart';
import 'package:brainy/screen/join.dart';
import 'package:flutter/material.dart';

import 'categories.dart';

class Home extends StatefulWidget {
  final String user;
  const Home({super.key, required this.user});


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20,top: 50,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome",style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.bold),),
                    Text(widget.user ,style: TextStyle(color: Color(0xff231942),fontSize: 30,fontWeight: FontWeight.bold),),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white24),
                  width:90,
                  child: Row(
                      children: [
                        Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.yellow[600],
                              shape: BoxShape.circle,),
                            child: Icon(Icons.star_outline_sharp,color: Colors.white,size: 25,)),
                        SizedBox(width: 5,),
                        Text("points")
                      ],
                    )),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Join()));
                    });
                  },
                  child:
                      Container(
                        width: 90,
                        decoration: BoxDecoration(color: Colors.grey[300],borderRadius: BorderRadius.all(Radius.circular(10))),
                        margin: EdgeInsets.all(5),
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20,),
                            Image.asset("images/join.png",width: 90,),
                            Text("Join",style: TextStyle(color: Color(0xff231942),fontWeight: FontWeight.bold,fontSize: 15),)
                          ],
                        ),),

                  ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Create()));
                    });
                  },
                  child: Container(
                        width: 90,
                        decoration: BoxDecoration(color: Colors.grey[300],borderRadius: BorderRadius.all(Radius.circular(10))),
                        margin: EdgeInsets.all(5),
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("images/add.png",width: 90,),
                            Text("Create",style: TextStyle(color: Color(0xff231942),fontWeight: FontWeight.bold,fontSize: 15),),
                          ],
                        ),),


                  ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Achievements()));
                    });
                  },
                  child: Container(
                    width: 90,
                    decoration: BoxDecoration(color: Colors.grey[300],borderRadius: BorderRadius.all(Radius.circular(10))),
                    margin: EdgeInsets.all(5),
                    height: 150,
                    child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("images/achievements.png",width: 90,),
                          Text("Achievements",style: TextStyle(color: Color(0xff231942),fontWeight: FontWeight.bold,fontSize: 12),),
                        ],
                  ),
                ),)
            ],),
            Text("explore -➔",style: TextStyle(color: Colors.deepPurple[900],fontSize: 25,fontWeight: FontWeight.bold),),
            Container(
              height: 425,
              child: GridView(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 200),
                children: [
                  categories(photo: "images/physics.png", name: "Physics", count: 12),
                  categories(photo: "images/electronics.png", name: "Electronics", count: 8),
                  categories(photo: "images/python.png", name: "Python", count: 20),
                  categories(photo: "images/cybersecurity.png", name: "CyberSecurity", count: 6),
                  categories(photo: "images/javascript.png", name: "JavaScript", count: 8),
                  categories(photo: "images/math.png", name: "Math", count: 25),
                  categories(photo: "images/drawing.png", name: "Drawing", count: 10),
              ],),
            )
          ],
        ),
      ),

    );
  }
}


