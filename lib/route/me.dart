import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class me extends StatefulWidget{
  const me({super.key});
  State<me> createState() => _me();
}
class _me extends State<me> {

  Widget build(BuildContext context){
    return Scaffold(
        body: const Center(
          child: Text("i'm me"),
        ),
    );
  }
}