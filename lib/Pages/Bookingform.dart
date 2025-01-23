import 'package:flutter/material.dart';
import 'package:super_app/Pages/payChangu_pop.dart';
import 'package:super_app/models/booking_model.dart';
import 'package:super_app/models/hostel_model.dart';
import 'package:super_app/services/booking_service.dart';
import 'package:url_launcher/url_launcher.dart'; // Adjust import path if needed

class BookingFormPage extends StatefulWidget {
  final Hostel hostel;

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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _bookingDate = DateTime.now(); // Default booking date
  }


Future<void> _submitBooking() async {
  if (_formKey.currentState?.validate() ?? false) {
    final bookingRequest = BookingRequest(
      boardingHouseId: widget.hostel.id,
      studentName: _nameController.text,
      emailAddress: _emailController.text,
      phoneNumber: _phoneController.text,
      bookingDate: _bookingDate.toIso8601String(),
      price: widget.hostel.bookingFee,
    );

    setState(() {
      _isLoading = true;
    });

    try {
      // Initiate booking and payment
      final result = await BookingService().createBooking(bookingRequest);

      // Open payment link
      if (result['status'] == 'success' && result['checkout_url'] != null) {
        final checkoutUrl = result['checkout_url'];
        if (await canLaunchUrl(checkoutUrl)) {
          await launchUrl(checkoutUrl);
        } else {
          throw 'Could not launch payment link.';
        }
      } else {
        throw 'Failed to initiate payment.';
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Hostel - ${widget.hostel.houseName}'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Book Your Stay at ${widget.hostel.houseName}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Your Email',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Your Phone',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Booking Fee: MWK ${widget.hostel.bookingFee}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: _submitBooking,
                          child: Text(
                            ' PayNow',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
