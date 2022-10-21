import 'package:docisay/route/MyHomePage.dart';
import 'package:docisay/route/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{

  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'DociSay Conversation Dialogue'),
      initialRoute: "/login",
      routes: {
        '/': (context) => MyHomePage(),
        '/login': (context) => Login(),

      },
    );
  }
}

