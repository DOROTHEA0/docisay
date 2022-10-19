import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget{
  const home({super.key});
  State<home> createState() => _home();
}
class _home extends State<home> {

  Widget build(BuildContext context){
    return Scaffold(
        body: const Center(
          child: Text("i'm home"),
        ),
    );
  }
}