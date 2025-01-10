import 'package:flutter/material.dart';
import './Pages/BottomNavbar.dart'; // Ensure the path to BottomNavbar.dart is correct.

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'University Business App',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: Bottomnavbar(), 
  ));
}
