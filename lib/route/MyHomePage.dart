import 'package:docisay/route/login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rhino_flutter/rhino.dart';
import 'package:docisay/api_interface/picovoice.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:firebase_core/firebase_core.dart';


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

    // 这里是picovoice
    // String keywordPath = "models/android/Hey-Peter_en_android_v2_1_0.ppn";
    // String contextPath = "models/android/0.rhn";
    // String accessKey = "rNv8gA47ss8Ic8Bsx95tZFyQTToXs/aD6fsltCtCq8KihHDJr5JtHQ==";
    //
    // infererenceCallback(RhinoInference inference){
    //   print(inference);
    // }
    // errorCallback(msg){
    //   print(msg+"haha");
    // }
    //picoVoiceInterface = new PicoVoiceInterface(accessKey, keywordPath, contextPath, wakeWordCallback, infererenceCallback, errorCallback);
    //picoVoiceInterface?.startPicoVoice();
    initAlan();

  }


  void initAlan() {
    //TODO get some voice input,then push something in pushToList
    AlanVoice.addButton(
        "2fef87232c0980a1d1e3a5d6d8f936412e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);

    AlanVoice.onCommand.add((command) {
      pushTolist(command.toString(), false);
      var commandName = command.data["command"] ?? "";
      if (commandName == "showAlert") {
        /// handle command "showAlert"
      }
    });

    AlanVoice.onEvent.add((event) {
      if(event.data['final'] != null && event.data['final']){
        pushTolist(event.data['text'], true);
      }else if(event.data['name'] =='text' && event.data['text'] != null){
        pushTolist(event.data['text'], false);
      }

    });
  }

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  Future<void> setDatas() async {
    await ref.set({
      "name": "john"

    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),

      ),
      body:
      Container(
        child: SingleChildScrollView(
          child: chatList(context),
        ),
      ),


      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  List<Widget> tiles=[];
  List<String> messages=[];
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
    setDatas();

    content = new Column(
      children: tiles,
    );
    return content;

  }
  Widget bubbles(BuildContext context,bool isMyself,String msg){
    if (isMyself) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BubbleSpecialOne(
            text: msg,
            isSender: isMyself,
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          BubbleSpecialOne(
            text: msg,
            isSender: isMyself,
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
