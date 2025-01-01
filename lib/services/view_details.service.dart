import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/view_details.dart';

class MarketplaceService {
  // Replace with your API endpoint (use a config file or env variables for flexibility)
  final String baseUrl = 'http://127.0.0.1:3000/marketplace';

  // Function to fetch details of a specific marketplace item by ID
  Future<MarketplaceDetailModel?> getItemDetails(int id) async {
    try {
      final uri = Uri.parse('$baseUrl/$id');

      // Make the HTTP GET request with a timeout
      final response = await http.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        // Parse the JSON if the response is successful
        return MarketplaceDetailModel.fromJson(json.decode(response.body));
      } else {
        // Log and throw an exception for non-200 responses
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
        throw Exception('Failed to load item details: ${response.reasonPhrase}');
      }
    } on http.ClientException catch (e) {
      // Handle client-side errors
      print('ClientException: $e');
      throw Exception('Failed to load item details due to client-side error');
    } on TimeoutException {
      // Handle timeout errors
      print('Error: Request timed out');
      throw Exception('Request timed out. Please try again later.');
    } catch (e) {
      // Handle all other exceptions
      print('Unexpected error: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
