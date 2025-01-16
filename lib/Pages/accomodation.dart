// address.dart
import 'package:flutter/material.dart';
import 'package:super_app/Pages/hostel.dart';

class AccomodationPage extends StatelessWidget {
  const AccomodationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accomodation'),
      ),
      body: HostelPage()
    );
  }
}
