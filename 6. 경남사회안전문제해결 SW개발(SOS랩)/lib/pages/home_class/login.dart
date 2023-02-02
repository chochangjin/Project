// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../main.dart';

class Login {
  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        '로그인 정보를 다시 확인하세요.',
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.blue,
    ));
  }

  void showSnackBar2(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'ID를 다시 확인하세요.',
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.blue,
    ));
  }

  void showSnackBar3(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        '비밀번호를 다시 확인하세요.',
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.blue,
    ));
  }

  void login_check(controller, controller2, context) {
    if (controller.text == '' && controller2.text == '') {
      Navigator.push(
          context, MaterialPageRoute(builder: (BuildContext) => MyApp()));
    } else if (controller.text == '' && controller2.text != '') {
      Login().showSnackBar3(context);
    } else if (controller.text != '' && controller2.text == '') {
      Login().showSnackBar2(context);
    } else {
      Login().showSnackBar(context);
    }
  }
}
