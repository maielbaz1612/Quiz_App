import 'package:brainy/screen/AvailableQuizes.dart';
import 'package:flutter/material.dart';

class categories extends StatefulWidget {
  const categories({super.key, required this.photo, required this.name, required this.count});
  final String photo;
  final String name;
  final int count;

  @override
  State<categories> createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Availablequizes()));
        });
      },
      child: Card(
        color: Color(0xFF5c4d7d),
        child:
      Column(
        children: [
          Image.asset(widget.photo,height: 150,),
          Text(widget.name,style: TextStyle(color: Colors.deepPurple[900],fontWeight: FontWeight.bold,fontSize: 15),),
          Text("${widget.count} Quiz",style: TextStyle(color: Colors.grey),),
        ],),),
    );
  }
}