import 'package:http/http.dart' as http;
import 'package:super_app/models/booking_model.dart';
import 'dart:convert';

class BookingService {
  static const String _baseUrl = 'http://localhost:3000/accomodation/create';

  Future<http.Response> createBooking(BookingRequest bookingRequest) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(bookingRequest.toJson()), // Ensure your model's `toJson()` method is implemented
      );

      // Check for success (201 Created)
      if (response.statusCode == 201) {
        print('Booking Successful');
        return response;
      } else {
        // Handle failure (non-201 responses)
        print('Failed to book: ${response.body}');
        throw Exception('Failed to create booking: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e'); // Rethrow the error so the UI can handle it
    }
  }
}
