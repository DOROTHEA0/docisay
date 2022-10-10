import 'dart:ffi';


import 'package:flutter/material.dart';
import 'package:rhino_flutter/rhino.dart';
import 'package:docisay/api_interface/picovoice.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DociSay',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'DociSay'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PicoVoiceInterface? picoVoiceInterface;
  bool isMyself = true;

  bool alanActive = false;
  @override
  void initState() {
    super.initState();

    String keywordPath = "models/android/Hey-Peter_en_android_v2_1_0.ppn";
    String contextPath = "models/android/0.rhn";
    String accessKey = "rNv8gA47ss8Ic8Bsx95tZFyQTToXs/aD6fsltCtCq8KihHDJr5JtHQ==";

    infererenceCallback(RhinoInference inference){
      print(inference);
    }
    errorCallback(msg){
      print(msg+"haha");
    }
    //picoVoiceInterface = new PicoVoiceInterface(accessKey, keywordPath, contextPath, wakeWordCallback, infererenceCallback, errorCallback);
    //picoVoiceInterface?.startPicoVoice();
    //TODO get some voice input,then push something in pushToList
    AlanVoice.addButton(
        "2fef87232c0980a1d1e3a5d6d8f936412e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: chatList(context),

      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  List<Widget> tiles=[];
  List<String> messages=["message","yes"];
  //TODO when there is something input ,then put it to our chatlist to show it
  void pushTolist(String message,bool isMyself){
      setState(() {
        tiles.add(bubbles(context, isMyself, message));
      });
  }

  Widget chatList(BuildContext context){
    Widget content;
    for(var item in messages){
      tiles.add(bubbles(context,true,item));
    }
    content = new Column(
      children: tiles,
    );
    return content;

  }
  Widget bubbles(BuildContext context,bool isMyself,String msg){
    if (isMyself) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BubbleSpecialOne(
            text: msg,
            isSender: false,
            color: Colors.purple.shade100,
            textStyle: const TextStyle(
              fontSize: 20,
              color: Colors.purple,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],

      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BubbleSpecialOne(
            text: msg,
            isSender: true,
            color: Colors.blue.shade100,
            textStyle: const TextStyle(
              fontSize: 20,
              color: Colors.blue,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }
  }
}
