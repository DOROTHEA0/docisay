import 'package:flutter/material.dart';
import 'package:rhino_flutter/rhino.dart';
import 'package:docisay/api_interface/picovoice.dart';
import 'package:alan_voice/alan_voice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  PicoVoiceInterface? picoVoiceInterface;

  @override
  void initState() {
    super.initState();

    String keywordPath = "models/android/Hey-Peter_en_android_v2_1_0.ppn";
    String contextPath = "models/android/0.rhn";
    String accessKey = "rNv8gA47ss8Ic8Bsx95tZFyQTToXs/aD6fsltCtCq8KihHDJr5JtHQ==";
    wakeWordCallback(){
      _incrementCounter();
    }
    infererenceCallback(RhinoInference inference){
      print(inference);
    }
    errorCallback(msg){
      print(msg);
    }
    //picoVoiceInterface = new PicoVoiceInterface(accessKey, keywordPath, contextPath, wakeWordCallback, infererenceCallback, errorCallback);
    //picoVoiceInterface?.startPicoVoice();
    AlanVoice.addButton(
        "2fef87232c0980a1d1e3a5d6d8f936412e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);
  }


  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have say HEY PETER this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
