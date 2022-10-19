

import 'package:docisay/route/chatBox.dart';
import 'package:docisay/route/home.dart';


import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import 'me.dart';




class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }
  int count=0;

  final _pages = [home(),chatBox(),me()];
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("DociSay:$_currentIndex"),
      ),
      body: _pages[_currentIndex],

        bottomNavigationBar: ConvexAppBar(
          items: [
          TabItem(icon: Icons.home,title: "Home"),
          TabItem(icon: Icons.record_voice_over),
          TabItem(icon: Icons.person,title: "Me"),],
          initialActiveIndex: 1,
          onTap: (i){
            _changPage(i);
          },
        ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void _changPage(int index){
    if(index!=_currentIndex){
      setState(() {
        _currentIndex =index;
      });
    }
  }

}
