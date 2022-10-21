import 'package:firebase_database/firebase_database.dart';
import 'dart:convert' as convert;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class User {
  String email;
  String passWord;
  bool isManager;
  User(this.email, this.passWord, this.isManager);

  String get uid => email.hashCode.toString();
}


class UserDao {
  //static DatabaseReference ref = FirebaseDatabase.instance.ref();
  static Future<void> addUser(User user) async {
    String userRef = "users/${user.uid}";
    DatabaseReference ref = FirebaseDatabase.instance.ref(userRef);
    await ref.set({
      "email": user.email,
      "password": user.passWord,
      "isManager": user.isManager
    });
  }

  static Future<User?> getUserbyId(String id) async {
    String userRef = "users/$id";
    DatabaseReference ref = FirebaseDatabase.instance.ref(userRef);
    final snapshot = await ref.get();
    if (snapshot.exists) {
      final email = await ref.child('email').get();
      final password = await ref.child('password').get();
      final isManager = await ref.child('isManager').get();
      return User(email.value.toString(), password.value.toString(), isManager.value.toString()=='true');
    }
    return null;
  }

  static Future<User?> getUserbyEmail(String email) async {
   return getUserbyId(email.hashCode.toString());
  }

  static Future<List<User>> getAllUsers() async {
    List<User> users = <User>[];

    return users;
  }
}