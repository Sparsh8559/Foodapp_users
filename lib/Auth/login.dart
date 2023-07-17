import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global/global.dart';
import '../mainScreens/home_screen.dart';
import '../widgets/errordialog.dart';
import '../widgets/laoding_dialog.dart';
import '../widgets/text_field.dart';
import 'authpage.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  formValidation(){
    if(emailcontroller.text.isNotEmpty && passwordcontroller.text.isNotEmpty)
      {
        loginNow();
      }
    else
      {
        showDialog(
            context: context,
            builder: (c)
            {
              return ErrorDialog(message: "Please write Email/Password",);
            });
      }
  }


  loginNow() async
  {
    showDialog(
        context: context,
        builder: (c)
        {
          return const LoadingDialog(message: "Checking Credentials",);
        });
    User? currentUser;
    await firebaseAuth.signInWithEmailAndPassword(email: emailcontroller.text.trim(), password: passwordcontroller.text.trim()).then((auth){
      currentUser = auth.user!;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c)
          {
            return ErrorDialog(message: error.message.toString());
          });
    });
    if(currentUser!=null)
      {
        readDataAndSetDataLocaly(currentUser!);
      }
  }

  Future readDataAndSetDataLocaly(User currentUser) async
  {
    await FirebaseFirestore.instance.collection("users").doc(currentUser.uid).get().then((snapshot)async{
      if(snapshot.exists)
        {
          await sharedPreferences!.setString("uid", currentUser.uid);
          await sharedPreferences!.setString("email", snapshot.data()!["email"]);
          await sharedPreferences!.setString("name", snapshot.data()!["name"]);
          await sharedPreferences!.setString("photoUrl",snapshot.data()!["photoURL"]);

          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
        }
      else
      {
        firebaseAuth.signOut();
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthPage()));

        showDialog(
            context: context,
            builder: (c)
            {
              return ErrorDialog(message: "No record found");
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Image.asset(
                "images/images/login.png",
                height: 270,
              ),
            )
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.email,
                  controller: emailcontroller,
                  hintText: "Email",
                  isobsecure: false,
                ),
                CustomTextField(
                    data: Icons.lock,
                    controller: passwordcontroller,
                    hintText: "Password"
                ),
              ],
            ),
          ),
          const SizedBox(height: 30,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10)
            ),
            onPressed: ()
            {
              formValidation();
            },
            child: const Text(
              "Sign In",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
