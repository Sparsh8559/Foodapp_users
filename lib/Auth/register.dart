import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:shared_preferences/shared_preferences.dart';
import '../global/global.dart';
import '../mainScreens/home_screen.dart';
import '../widgets/errordialog.dart';
import '../widgets/laoding_dialog.dart';
import '../widgets/text_field.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();


  XFile? imageXFile;
  final ImagePicker _imagePicker = ImagePicker();

  String sellerImageUrl = "";

  Future<void> _getImage() async{
    imageXFile= await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageXFile;
    });
  }

  Future<void> formValidation() async {
    if (imageXFile== null)
      {
        showDialog(context: context, builder: (c){
          return ErrorDialog(message: "Please add image",);
        });
      }
    else
      {
        if(passwordcontroller.text == confirmpasswordcontroller.text)
          {
            if(passwordcontroller.text.isNotEmpty  && emailcontroller.text.isNotEmpty &&  namecontroller.text.isNotEmpty )
              {
                showDialog(
                    context: context,
                    builder: (c){
                      return const LoadingDialog(
                        message: "Registering account",
                      );
                    });

                String filename =DateTime.now().millisecondsSinceEpoch.toString();
                fStorage.Reference reference= fStorage.FirebaseStorage.instance.ref().child("users").child(filename);
                fStorage.UploadTask uploadTask= reference.putFile(File(imageXFile!.path));
                fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete((){});
                await taskSnapshot.ref.getDownloadURL().then((url){
                  sellerImageUrl=url;

                  authenticate();
                });
              }
            else
              {
                showDialog(context: context, builder: (c){
                  return ErrorDialog(message: "Please write required info for registration",);
                });
              }
          }
        else
          {
            showDialog(context: context, builder: (c){
              return ErrorDialog(message: "Password do not match with confirm password",);
            });
          }
      }
  }

 void authenticate() async
 {
   User? currentUser;
   await firebaseAuth.createUserWithEmailAndPassword(email: emailcontroller.text.trim(), password: passwordcontroller.text.trim()).then((auth) {
     currentUser = auth.user;
   }).catchError((error){
     Navigator.pop(context);
     showDialog(context: context, builder: (c){
       return ErrorDialog(message: error.message.toString(),);
     });
   });
   if(currentUser !=null){
     saveDataToFirestore(currentUser!).then((value){
       Navigator.pop(context);
       Route newRoute = MaterialPageRoute(builder: (c)=> HomeScreen());
       Navigator.pushReplacement(context, newRoute);
     });
   }
 }

  Future saveDataToFirestore(User currentUser)async {
    FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
      "uid": currentUser.uid,
      "email": currentUser.email,
      "name":namecontroller.text.trim(),
      "photoURL": sellerImageUrl,
      "status": "approve",
      "userCart": ['garbageValue']
    });


    //save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email.toString());
    await sharedPreferences!.setString("name", namecontroller.text.trim());
    await sharedPreferences!.setString("photoUrl",sellerImageUrl);
    await sharedPreferences!.setStringList("userCart",['garbageValue'] );

 }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
                _getImage();
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width*0.2,
                backgroundColor: Colors.white,
                backgroundImage: imageXFile==null ? null : FileImage(File(imageXFile!.path)),
                child: imageXFile==null ? Icon(
                  Icons.add_photo_alternate,
                  size: MediaQuery.of(context).size.width*0.2,
                  color: Colors.grey,
                ) : null,
              ),
            ),
            const SizedBox(height: 10,),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      data: Icons.person,
                      controller: namecontroller,
                      hintText: "Name",
                      isobsecure: false,
                    ),
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
                    CustomTextField(
                      data: Icons.lock,
                      controller: confirmpasswordcontroller,
                      hintText: "Confirm Password"
                    ),
                  ],
                )),
            const SizedBox(height: 10,),
            ElevatedButton(
              child: const Text(
                "Sign Up",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10)
              ),
              onPressed: (){
                formValidation();
              },
            )

          ],
        ),
      ),
    );
  }
}
