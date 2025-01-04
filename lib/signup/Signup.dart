import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      try {
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign up successful!')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign up failed: $e')),
        );
      }
    }
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }

  Widget _buildSocialLoginButton(String label, IconData icon, Color color, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(double.infinity, 50),
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextFormField(
                    controller: _emailController,
                    label: "Email",
                    validator: (value) => value?.isEmpty ?? true || !value!.contains('@')
                        ? 'Please enter a valid email'
                        : null,
                  ),
                  _buildTextFormField(
                    controller: _passwordController,
                    label: "Password",
                    obscureText: true,
                    validator: (value) => value?.isEmpty ?? true || value!.length < 6
                        ? 'Password must be at least 6 characters'
                        : null,
                  ),
                  _buildTextFormField(
                    controller: _confirmPasswordController,
                    label: "Confirm Password",
                    obscureText: true,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please confirm your password'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
            ),
            const Divider(height: 40),
            _buildSocialLoginButton(
              "Sign Up with Google",
              Icons.g_mobiledata,
              Colors.red,
              () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Google Sign Up pressed')),
              ),
            ),
            _buildSocialLoginButton(
              "Sign Up with Facebook",
              Icons.facebook,
              Colors.blue,
              () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Facebook Sign Up pressed')),
              ),
            ),
            _buildSocialLoginButton(
              "Sign Up with Apple",
              Icons.apple,
              Colors.black,
              () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Apple Sign Up pressed')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
