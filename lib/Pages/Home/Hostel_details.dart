import 'package:flutter/material.dart';
import 'package:super_app/models/hostel_model.dart';

class HostelDetailPage extends StatelessWidget {
  final Hostel hostel;

  HostelDetailPage({required this.hostel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hostel.houseName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              hostel.image.isNotEmpty ? hostel.image : 'https://via.placeholder.com/150',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              hostel.houseName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Location: ${hostel.location}'),
            Text('Room Type: ${hostel.roomType}'),
            Text('Gender Category: ${hostel.genderCategory}'),
            Text('Room Number: ${hostel.roomNumber}'),
            Text('Price: MWK ${hostel.price} / month'),
            Text('Booking Fee: MWK ${hostel.bookingFee}'),
            Text('Landlord Phone: ${hostel.landlordPhoneNumber}'),
            Text('Status: ${hostel.status}'),
            Text('Max People: ${hostel.maxPeople}'),
          ],
        ),
      ),
    );
  }
}
