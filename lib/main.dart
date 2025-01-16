import 'package:flutter/material.dart';
import 'package:super_app/Pages/BottomNavbar.dart';
import 'package:super_app/Pages/cartpage.dart';
import 'package:super_app/services/cart_services.dart';
import 'package:super_app/signup/Login.dart';
import 'package:super_app/signup/Signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that widget binding is initialized before accessing SharedPreferences
  
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token'); // Check if token exists

  runApp(MyApp(token: token)); // Pass token to the app
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'University Business App',
     // initialRoute: token != null ? '/home' : '/login', // Check if token exists to determine initial route
     home: Bottomnavbar(),
      routes: {
        '/signup': (context) => SignupPage(),
        '/login': (context) => LoginPage(),
        
        '/cartpage': (context) => Cartpage(cartService: CartService('http://127.0.0.1:3000/cart')),
      },
    );
  }
}
