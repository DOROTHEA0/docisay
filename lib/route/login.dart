import 'package:docisay/route/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:docisay/main.dart';
import 'package:docisay/models/user.dart';
const users = const {
  '123@123.com': '12345',
  '1': 'hunter',
};

class Login extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    debugPrint('User: ${data.name}, Password: ${data.password}');
    User? user = await UserDao.getUserbyId(data.name.hashCode.toString());
    return Future.delayed(loginTime).then((_) {
      if (user == null) {
        return 'User not exists';
      }
      if (user.passWord != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    UserDao.addUser(User(data.name!, data.password!, false));
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: AssetImage('assets/images/logo.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushNamedAndRemoveUntil('/',(Route route)=>false);
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}