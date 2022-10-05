import 'package:flutter/material.dart';


import 'package:picovoice_flutter/picovoice_manager.dart';
import 'package:picovoice_flutter/picovoice_error.dart';
import 'package:rhino_flutter/rhino.dart';

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
  PicovoiceManager? picovoiceManager;

  @override
  void initState() {
    super.initState();
    initPicovoice();
    startPicoVoice();
  }

  Future<void> initPicovoice() async {
    String keywordPath = "models/android/Hey-Peter_en_android_v2_1_0.ppn";
    String contextPath = "models/android/0.rhn";

    String accessKey = "rNv8gA47ss8Ic8Bsx95tZFyQTToXs/aD6fsltCtCq8KihHDJr5JtHQ==";
    picovoiceManager = PicovoiceManager.create(accessKey, keywordPath,
        wakeWordCallback, contextPath, infererenceCallback);
  }

  void wakeWordCallback(){
    _incrementCounter();
  }

  void infererenceCallback(RhinoInference inference){
    if(inference.isUnderstood!){
      String intent = inference.intent!;
      Map<String, String> slots = inference.slots!;
      // take action based on inferred intent and slot values
    }
    else{
      // handle unsupported commands
    }
  }


  void errorCallback(PicovoiceException error) {
    if (error.message != null) {
      print(error.message);
    }
  }

  Future<void> startPicoVoice() async {
    try {
      if (picovoiceManager == null) {
        throw PicovoiceInvalidStateException(
            "picovoiceManager not initialized.");
      }
      await picovoiceManager!.start();
    } on PicovoiceInvalidArgumentException catch (ex) {
      errorCallback(PicovoiceInvalidArgumentException(
          "${ex.message}\nEnsure your accessKey 'accessKey' is a valid access key."));
    } on PicovoiceActivationException {
      errorCallback(
          PicovoiceActivationException("AccessKey activation error."));
    } on PicovoiceActivationLimitException {
      errorCallback(PicovoiceActivationLimitException(
          "AccessKey reached its device limit."));
    } on PicovoiceActivationRefusedException {
      errorCallback(PicovoiceActivationRefusedException("AccessKey refused."));
    } on PicovoiceActivationThrottledException {
      errorCallback(PicovoiceActivationThrottledException(
          "AccessKey has been throttled."));
    } on PicovoiceException catch (ex) {
      errorCallback(ex);
    }
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
