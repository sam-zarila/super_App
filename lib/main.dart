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
  final CartService cartService = CartService('http://127.0.0.1:3000/cart'); // Initialize CartService

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Set initial route to '/' (Login page)
      routes: {
        '/': (context) => AuthPage(), // AuthPage for Login/Signup
        '/login': (context) => LoginPage(), // LoginPage route
        '/signup': (context) => SignupPage(), // SignupPage route
        '/bottomnavbar': (context) => Bottomnavbar(), // Bottom navbar route
        '/cart': (context) => FutureBuilder<String>(
              future: _getUserId(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return const Scaffold(
                    body: Center(child: Text('Error loading user data')),
                  );
                } else {
                  return Cartpage(
                    cartService: cartService,
                    userId: snapshot.data!,
                  );
                }
              },
            ),
      },
    );
  }

  // Fetches the user ID from Firebase Authentication
  Future<String> _getUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid; // Returns the Firebase user ID
    } else {
      throw Exception('No user signed in'); // Throws an error if no user is signed in
    }
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
                Navigator.pushNamed(context, '/login'); // Navigate to login page
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup'); // Navigate to signup page
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
