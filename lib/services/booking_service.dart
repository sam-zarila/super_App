import 'package:http/http.dart' as http;
import 'package:super_app/models/booking_model.dart';
import 'dart:convert';


class BookingService {
  static const String _baseUrl = 'http://localhost:3000/accomodation/create';

  Future<void> createBooking(BookingRequest bookingRequest) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(bookingRequest.toJson()),
      );

      if (response.statusCode == 200) {
        // Handle success (e.g., show a success message or navigate to another page)
        print('Booking Successful');
      } else {
        // Handle failure (e.g., show an error message)
        print('Failed to book: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
