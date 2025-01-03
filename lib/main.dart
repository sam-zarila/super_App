import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Pages/BottomNavbar.dart';
import 'firebase_options.dart';  // This file will be generated after Firebase setup

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);  // Use the generated file
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Bottomnavbar(),
    );
  }
}
