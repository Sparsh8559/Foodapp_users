import 'dart:async';

import 'package:flutter/material.dart';

import '../Auth/authpage.dart';
import '../global/global.dart';
import '../mainScreens/home_screen.dart';

class MyFlashScreen extends StatefulWidget {
  const MyFlashScreen({Key? key}) : super(key: key);

  @override
  State<MyFlashScreen> createState() => _MyFlashScreenState();
}

class _MyFlashScreenState extends State<MyFlashScreen> {

  startTimer(){

    Timer(const Duration(seconds: 5), ()async {

      if(firebaseAuth.currentUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const HomeScreen()));
      }
      else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const AuthPage()));
      }

    });
  }

 @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.amber, Colors.cyan],
              begin: FractionalOffset(0.0,0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0,1.0],
          tileMode: TileMode.clamp)
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("images/images/welcome.png"),
              ),
              const SizedBox(height: 10,),
              const Padding(padding: EdgeInsets.all(18.0),
              child: Text(
                "Order Food Online",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white60,
                  fontFamily: 'Train',
                  fontSize: 20,
                  letterSpacing: 3,
                ),
              ),)
            ],
          ),
        ),
      ),
    );
  }
}