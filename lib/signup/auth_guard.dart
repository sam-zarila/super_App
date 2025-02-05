import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:super_app/signup/Login.dart';
import 'package:super_app/signup/Signup.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;

  const AuthGuard({Key? key, required this.child}) : super(key: key);

  void _showAuthDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Allow user to cancel
      builder: (context) => AlertDialog(
        title: const Text("Login Required"),
        content: const Text("You need to log in or sign up to continue,only quick services can be accessed without loggin in."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Dismiss popup
            },
            child: const Text("Cancel"), // Allow user to explore without login
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: const Text("Login"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
            },
            child: const Text("Sign Up"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Future.delayed(Duration.zero, () => _showAuthDialog(context));
    }

    return child; // If user is logged in, show the page normally
  }
}
