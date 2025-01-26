import 'package:http/http.dart' as http;
import 'package:super_app/models/booking_model.dart';
import 'dart:convert';

class BookingService {
  static const String _baseUrl = 'http://127.0.0.1:3000/accomodation/create';

  Future<Map<String, dynamic>> createBooking(BookingRequest bookingRequest) async {
    try {
      // Send the booking request to the backend
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(bookingRequest.toJson()),
      );

      // Log the raw response for debugging
      print('Raw Response: ${response.body}');

      // Check if the request was successful
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = json.decode(response.body);

        // Log the parsed response for debugging
        print('Parsed Response: $responseBody');

        // Validate the response structure
        if (responseBody['BookingNumber'] != null) {
          // If the booking is successful, return the booking details
          return {
            'status': 'success',
            'bookingDetails': responseBody,
          };
        } else {
          throw Exception('Booking failed: Invalid response structure');
        }
      } else {
        // Handle server errors
        print('Failed to book: ${response.body}');
        throw Exception('Failed to create booking: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }
}