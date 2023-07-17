import 'package:flutter/material.dart';
import 'package:users_app/Auth/register.dart';

import 'login.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.cyan,Colors.amber],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0,1.0],
                  tileMode: TileMode.clamp,
                )
              ),
            ),
            automaticallyImplyLeading: false,
            title: const Text("DORO",
            style: TextStyle(
                fontSize: 50,
              fontFamily: "Train",
              color: Colors.white,

            ),),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.lock,color: Colors.white,) ,
                  text: "Login",
                ),
                Tab(
                  icon: Icon(Icons.person,color: Colors.white,) ,
                  text: "Register",
                )
              ],
              indicatorColor: Colors.white38,
              indicatorWeight: 6,
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber,Colors.cyan],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              )
            ),
            child: const TabBarView(
              children: [
                LoginScreen(),
                Register(),
              ],
            ),
          ),
        ));
  }
}
