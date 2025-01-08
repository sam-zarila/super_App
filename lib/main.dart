import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:super_app/Pages/BottomNavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:super_app/Pages/cartpage.dart';
import 'package:super_app/services/cart_services.dart';
import 'package:super_app/signup/Login.dart';
import 'package:super_app/signup/Signup.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with correct options
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
      initialRoute: '/', // Set initial route to '/' (Login page)
      routes: {
        '/': (context) => AuthPage(),  // AuthPage for Login/Signup
        '/login': (context) => LoginPage(),  // LoginPage route
        '/signup': (context) => SignupPage(),  // SignupPage route
        '/bottomnavbar': (context) => Bottomnavbar(),  // Bottom navbar route
        '/cart': (context) => Cartpage(
            cartService: CartService('http://127.0.0.1:3000/cart'),
            userId:'' ,
           
        ),
      },
    );
  }
}

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login / Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');  // Navigate to login page
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');  // Navigate to signup page
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
