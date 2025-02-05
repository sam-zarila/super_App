import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:super_app/Pages/BottomNavbar.dart';
import 'package:super_app/Pages/cartpage.dart';
import 'package:super_app/services/cart_services.dart';
import 'package:super_app/signup/Login.dart';
import 'package:super_app/signup/Signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_app/signup/auth_guard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCWFa4tCHalRUqPkmfxVtrAbcXkC9negA8",
        authDomain: "superapp-c7cdb.firebaseapp.com",
        projectId: "superapp-c7cdb",
        storageBucket: "superapp-c7cdb.appspot.com",
        messagingSenderId: "802147518690",
        appId: "1:802147518690:android:a2d203d3708083dfc8f6bb",
        measurementId: "",
      ),
    );
    print("✅ Firebase initialized successfully");
  } catch (e) {
    print("❌ Failed to initialize Firebase: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'University Business App',
      initialRoute: '/Bottomnavbar', // Set initial route to bottom navbar
      routes: {
        '/Bottomnavbar': (context) => const Bottomnavbar(), // ✅ Registered route
        '/signup': (context) => const SignupPage(),
        '/login': (context) => const LoginPage(),
        '/cartpage': (context) => _authGuard(context, CartPage(cartService: CartService('http://127.0.0.1:3000/cart'))),
      },
    );
  }

  /// Ensures restricted pages require login
  Widget _authGuard(BuildContext context, Widget page) {
    return AuthGuard(child: page);
  }
}
