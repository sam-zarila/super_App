import 'package:http/http.dart' as http;
import 'package:super_app/models/booking_model.dart';
import 'dart:convert';

class BookingService {
  static const String _baseUrl = 'http://127.0.0.1:3000/accomodation/create';

  Future<Map<String, dynamic>> createBooking(BookingRequest bookingRequest) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(bookingRequest.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Booking Successful');
        final responseBody = json.decode(response.body);

        // Validate response structure and extract checkout URL
        if (responseBody['statusCode'] == 200 && responseBody['data'] != null) {
          final checkoutUrl = responseBody['data']['checkout_url'];
          if (checkoutUrl != null) {
            return {
              'status': 'success',
              'checkout_url': checkoutUrl,
            };
          } else {
            throw Exception('Payment initiation failed: Checkout URL missing');
          }
        } else {
          throw Exception('Payment initiation failed: Invalid response structure');
        }
      } else {
        print('Failed to book: ${response.body}');
        throw Exception('Failed to create booking: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }
}
