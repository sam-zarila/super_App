import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:super_app/Pages/BottomNavbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with correct options
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAD_x-PZoh4I7SMXTjLPmuOjIe0T3s1DOQ",
      authDomain: "nthananaapp-944bf.firebaseapp.com",
      projectId: "nthananaapp-944bf",
      storageBucket: "nthananaapp-944bf.appspot.com",
      messagingSenderId: "246842410163",
      appId: "1:246842410163:web:abcd1234efgh5678",
    ),
  );

  runApp(const MaterialApp(
    home: Bottomnavbar(),
  ));
}
