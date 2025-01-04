import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:super_app/Pages/BottomNavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:super_app/signup/Login.dart';
import 'package:super_app/signup/Signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAD_x-PZoh4I7SMXTjLPmuOjIe0T3s1DOQ",
      authDomain: "nthananaapp-944bf.firebaseapp.com",
      projectId: "nthananaapp-944bf",
      storageBucket: "nthananaapp-944bf.appspot.com",
      messagingSenderId: "246842410163",
      appId: "1:246842410163:web:abcd1234efgh5678",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Set initial route to '/' (AuthPage)
      routes: {
        '/': (context) => AuthPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/bottomnavbar': (context) => Bottomnavbar(),  // Ensure that this is the destination
        '/cart': (context) => Cartpage(cartService: CartService(), userId: 'sampleUserId'), // Example CartPage route
      },
    );
  }
}
