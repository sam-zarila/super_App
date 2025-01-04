import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:super_app/Pages/BottomNavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:super_app/signup/Login.dart';
import 'package:super_app/signup/Signup.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with correct options
  await Firebase.initializeApp(
    options:  FirebaseOptions(
      apiKey: "AIzaSyAD_x-PZoh4I7SMXTjLPmuOjIe0T3s1DOQ",
      authDomain: "nthananaapp-944bf.firebaseapp.com",
      projectId: "nthananaapp-944bf",
      storageBucket: "nthananaapp-944bf.appspot.com",
      messagingSenderId: "246842410163",
      appId: "1:246842410163:web:abcd1234efgh5678",
    ),
  );

  // Check if the user is logged in
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
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),  // Listen for auth state changes
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            // If user is logged in, navigate to BottomNavbar
            return Bottomnavbar();
          } else {
            // If no user is logged in, show login/signup screen
            return AuthPage(); // This will show the login/signup screen
          }
        },
      ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),  // Navigate to login page
                );
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),  // Navigate to signup page
                );
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
