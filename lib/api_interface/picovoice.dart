import 'package:picovoice_flutter/picovoice_manager.dart';
import 'package:picovoice_flutter/picovoice_error.dart';


class PicoVoiceInterface {
  final accessKey;
  PicovoiceManager? picoVoiceManager;
  String keywordPath;
  String contextPath;
  var wakeWordCallback;
  var infererenceCallback;
  var errorCallback;

  PicoVoiceInterface(this.accessKey, this.keywordPath, this.contextPath, this.wakeWordCallback, this.infererenceCallback, this.errorCallback){
    initPicoVoice();
  }

  Future<void> initPicoVoice() async {
    picoVoiceManager = PicovoiceManager.create(accessKey, keywordPath,
        wakeWordCallback, contextPath, infererenceCallback);
  }

  Future<void> startPicoVoice() async {
    try {
      if (picoVoiceManager == null) {
        throw PicovoiceInvalidStateException(
            "picovoiceManager not initialized.");
      }
      await picoVoiceManager!.start();
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
}