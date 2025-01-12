import 'package:flutter/material.dart';
import 'package:super_app/Pages/BottomNavbar.dart';
import 'package:super_app/Pages/cartpage.dart';
import 'package:super_app/services/cart_services.dart';
import 'package:super_app/signup/Login.dart';
import 'package:super_app/signup/Signup.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'University Business App',
    initialRoute: '/login',
    // home: Bottomnavbar(), 
     routes: {
        '/signup': (context) => SignupPage(),
        '/login': (context) => LoginPage(),
         '/cartpage': (context) => Cartpage(cartService: CartService('http://127.0.0.1:3000/cart'),), 
     
      },
  ));
}
