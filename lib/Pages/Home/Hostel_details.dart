import 'package:flutter/material.dart';
import 'package:super_app/models/hostel_model.dart';

class HostelDetailPage extends StatelessWidget {
  final Hostel hostel;

  HostelDetailPage({required this.hostel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          hostel.houseName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hostel Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  hostel.image.isNotEmpty ? hostel.image : 'https://via.placeholder.com/150',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),

              // Hostel Name
              Text(
                hostel.houseName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),

              SizedBox(height: 8),

              // Hostel Details
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailRow(
                      icon: Icons.location_on,
                      title: 'Location',
                      value: hostel.location,
                    ),
                    DetailRow(
                      icon: Icons.bed,
                      title: 'Room Type',
                      value: hostel.roomType,
                    ),
                    DetailRow(
                      icon: Icons.people,
                      title: 'Gender Category',
                      value: hostel.genderCategory,
                    ),
                    DetailRow(
                      icon: Icons.numbers,
                      title: 'Room Number',
                      value: hostel.roomNumber,
                    ),
                    DetailRow(
                      icon: Icons.price_change,
                      title: 'Price',
                      value: 'MWK ${hostel.price} / month',
                    ),
                    DetailRow(
                      icon: Icons.payment,
                      title: 'Booking Fee',
                      value: 'MWK ${hostel.bookingFee}',
                    ),
                    DetailRow(
                      icon: Icons.phone,
                      title: 'Landlord Phone',
                      value: hostel.landlordPhoneNumber,
                    ),
                    DetailRow(
                      icon: Icons.info_outline,
                      title: 'Status',
                      value: hostel.status,
                    ),
                    DetailRow(
                      icon: Icons.group,
                      title: 'Max People',
                      value: '${hostel.maxPeople}',
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Contact Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Add contact landlord functionality here
                  },
                  icon: Icon(Icons.phone),
                  label: Text('Book Now'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: Colors.teal,
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const DetailRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              '$title: $value',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}