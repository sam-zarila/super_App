import 'package:flutter/material.dart';
import 'package:super_app/Pages/cartpage.dart';
import 'package:super_app/services/cart_services.dart';
import 'package:super_app/signup/Login.dart';
import 'package:super_app/signup/Signup.dart';
import './Pages/BottomNavbar.dart'; // Ensure the path to BottomNavbar.dart is correct.

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'University Business App',
    initialRoute: '/login',
    // home: Bottomnavbar(), 
     routes: {
        '/signup': (context) => SignupPage(),
        '/login': (context) => LoginPage(),
         '/bottomnavbar': (context) => BottomnavBar(), 
     
      },
  ));
}
