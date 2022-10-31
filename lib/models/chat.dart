import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';


class Chat {
  bool isSender;
  String content;
  int serials;

  Chat(this.isSender, this.content, this.serials);
}