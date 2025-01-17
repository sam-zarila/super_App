import 'package:flutter/material.dart';
import 'package:super_app/models/booking_model.dart';
import 'package:super_app/models/hostel_model.dart';
import 'package:super_app/services/booking_service.dart';

class BookingFormPage extends StatefulWidget {
  final Hostel hostel; // You pass the hostel details here.

  BookingFormPage({required this.hostel});

  @override
  _BookingFormPageState createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  late DateTime _bookingDate;

  @override
  void initState() {
    super.initState();
    _bookingDate = DateTime.now(); // Default booking date
  }

  Future<void> _submitBooking() async {
    if (_formKey.currentState?.validate() ?? false) {
      final bookingRequest = BookingRequest(
        boardingHouseId: widget.hostel.id, // Assuming hostel has an `id` field.
        studentName: _nameController.text,
        emailAddress: _emailController.text,
        phoneNumber: _phoneController.text,
        bookingDate: _bookingDate.toIso8601String(),
        price: widget.hostel.bookingFee, // Pass booking fee automatically.
      );

      final bookingService = BookingService();
      await bookingService.createBooking(bookingRequest);

      // Show success or failure message based on API response
      // You can navigate to another page or show a dialog here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Hostel - ${widget.hostel.houseName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Your Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Your Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Your Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text('Booking Fee: MWK ${widget.hostel.bookingFee}'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitBooking,
                child: Text('Confirm Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
