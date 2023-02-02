import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import '04. qr_view.dart';

class Loading extends StatelessWidget {
  String obj_id = "";
  Loading(this.obj_id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 239, 214),
      body: Center(
          child: AnimatedSplashScreen(
              backgroundColor: Colors.white,
              splashIconSize: 300,
              duration: 10000,
              splash: Image.asset(
                'assets/img/loading.gif',
                fit: BoxFit.fill,
              ),
              nextScreen: QrView(obj_id))),
    );
  }
}
