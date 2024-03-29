import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:users_app/assistant_methods/cart_item_counter.dart';
import 'Flash Screen/flashscreen.dart';
import 'global/global.dart';

Future<void> main() async
{
  await Firebase.initializeApp();
  sharedPreferences =await SharedPreferences.getInstance();

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c)=>CartItemCounter()),
      ],
      child: MaterialApp(
        title: 'Users App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyFlashScreen(),
      ),
    );
  }
}
